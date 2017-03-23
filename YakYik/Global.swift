//
//  YYGlobal.swift
//  YakYik
//
//  Created by Admin on 3/22/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import Firebase

let Debug = false
let Defaults = UserDefaults.standard
let FirebaseReference = FIRDatabase.database().reference()

var ThisYik: Yik!
var ThisComment: Comment!
var ThisUser: User!

var Refreshing = false
var FromNewNote = false

//View Controllers
var ThisHomeTableViewController = HomeTableViewController()

struct FirebasePath {
    
    static let yiks = "/yiks/"
    static let users = "/users/"
    static let comments = "/comments/"
}

struct DefaultType {
    
    static let isFirstLaunch = "isFirstLaunch"
}
