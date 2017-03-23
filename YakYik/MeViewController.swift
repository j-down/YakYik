//
//  MeViewController.swift
//  YakYik
//
//  Created by Admin on 3/22/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

class MeViewController: UIViewController {
    
    @IBOutlet var karmaCountLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        
        karmaCountLabel.text = String(ThisUser.karma)
    }
}
