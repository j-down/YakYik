//
//  CommentsTableViewController.swift
//  YakYik
//
//  Created by Admin on 3/22/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

class CommentsTableViewController: UITableViewController {
    
    var yik = Yik()
    var comments = [Comment]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        
        
    }
}

//MARK: UITableViewDelegate
extension CommentsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CommentsTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as! CommentsTableViewCell
        let comment = comments[indexPath.row]
        
        cell.setup(for: comment)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}
