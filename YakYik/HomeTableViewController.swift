//
//  FirstViewController.swift
//  YakYik
//
//  Created by Admin on 3/22/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import UIKit
import Firebase

class HomeTableViewController: UITableViewController {
    
    @IBOutlet var tableViewFooter: UIView!
    
    var yiks = [Yik]()
    var newYikRefHandle: FIRDatabaseHandle?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        
        /*
         //FIX User creation
        if !Defaults.bool(forKey: DefaultType.isFirstLaunch) {
            
            setupFirstLaunch()
        }
        else {
            
           // loadUser()
        }*/
        
        createUser()
        
        setupTableView()
        setupData()
    }
    
    func setupFirstLaunch() {
        
        createUser()
        
        Defaults.set(true, forKey: DefaultType.isFirstLaunch)
    }
    
    func setupTableView() {
        
        tableView.tableFooterView = tableViewFooter
        tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier())
    }
    
    func setupData() {
        
        observeYiks()
    }
    
    func observeYiks() {
        
        let noteQuery = FirebaseReference.child("yiks")
        
        newYikRefHandle = noteQuery.observe(.childAdded, with: { (snapshot) -> Void in
            
            if let yikData = snapshot.value as? Dictionary<String, String> {
                
                if let time = yikData["time"] as String!,
                    let lat = yikData["lat"] as String!,
                    let long = yikData["long"] as String!,
                    let text = yikData["text"] as String!,
                    let upvotes = yikData["upvotes"] as String!,
                    let downvotes = yikData["downvotes"] as String!,
                    let user = yikData["user"] as String!,
                    let uuid = yikData["uuid"] as String!{
                    
                    if let yik = Yik(uuid: uuid, time: time, lat: lat,  long: long, text: text, upvotes: upvotes, downvotes: downvotes, user: user) {
                        
                        self.add(new: yik)
                    }
                }
            }
        })
        
        finishLoading()
    }
    
    func add(new yik: Yik) {
        
        yiks.append(yik)
        
        tableView.reloadData()
    }
    
    func createUser() {
        
        let userKey = FirebaseReference.child("users").childByAutoId().key
        
        ThisUser = User(uuid: userKey)
        
        Defaults.set(userKey, forKey: User.userDefault.uuid)
        Defaults.set(0, forKey: User.userDefault.karma)
        
        let userUpdates = ["\(FirebasePath.users)/\(ThisUser.uuid)/stats/" : ThisUser.toAny()]
        
        FirebaseReference.updateChildValues(userUpdates)
    }
    
    func loadUser() {
        
        ThisUser.uuid = Defaults.value(forKey: User.userDefault.uuid) as! String
        ThisUser.karma = Defaults.integer(forKey: User.userDefault.karma)
    }
    
    func create(new yik: Yik) {
        
        yiks.append(yik)
        
        let yikKey = FirebaseReference.child("yiks").childByAutoId().key
        
        yik.uuid = yikKey
        
        ThisUser.increaseKarma()
        
        let noteUpdates = [ "\(FirebasePath.yiks)\(yikKey)" : yik.toAny()]
        let userNoteUpdates = [ "\(FirebasePath.users)/\(ThisUser.uuid)/yiks/\(yikKey)" : yik.toAny()]
        let userStatUpdates = [ "\(FirebasePath.users)/\(ThisUser.uuid)/stats/" : ThisUser.toAny()]
        
        FirebaseReference.updateChildValues(noteUpdates)
        FirebaseReference.updateChildValues(userNoteUpdates)
        FirebaseReference.updateChildValues(userStatUpdates)
        
        refreshPage()
    }
    
    func finishLoading() {
        
        
    }
    
    func refreshPage() {
        
        tableView.reloadData()
    }
}

//MARK: UITableViewDelegate
extension HomeTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return yiks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "HomeTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as! HomeTableViewCell
        let yik = yiks[indexPath.row]
        
        cell.setup(for: yik)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = CommentsTableViewController()
        let cell = tableView.cellForRow(at: indexPath) as! HomeTableViewCell
        
        viewController.yik = cell.yik
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 175
    }
}
