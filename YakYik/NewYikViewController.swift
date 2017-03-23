//
//  NewYikViewController.swift
//  YakYik
//
//  Created by Admin on 3/22/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

class NewYikViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var postButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func setup() {
        
        toolBar.removeFromSuperview()
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    @IBAction func postButtonPressed(_ sender: Any) {
        
        let currentDate = NSDate()
        
        let time = String(describing: currentDate)
        let lat = ""
        let long = ""
        let text = textField.text ?? ""
        let upvotes = "0"
        let downvotes = "0"
        let user = ThisUser.uuid
        
        if let yik = Yik(time: time, lat: lat,  long: long, text: text, upvotes: upvotes, downvotes: downvotes, user: user) {
            
            ThisHomeTableViewController.create(new: yik)
        }
        
        dismiss(animated: true)
    }
}
