//
//  YYYik.swift
//  YakYik
//
//  Created by Admin on 3/22/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

class Yik: NSObject {
    
    var uuid: String
    var time: String
    var lat: String
    var long: String
    var text: String
    var upvotes: String
    var downvotes: String
    var user: String
    
    init?(uuid: String = "Nil", time: String = "Nil", lat: String = "0.0",  long: String = "0.0", text: String = "Nil", upvotes: String = "0", downvotes: String = "0", user: String = "Nil") {
        
        self.uuid = uuid
        self.time = time
        self.lat = lat
        self.long = long
        self.text = text
        self.upvotes = upvotes
        self.downvotes = downvotes
        self.user = user
        
    }
    
    func votes() -> Int {
        
        if let upvotes = Int(upvotes), let downvotes = Int(downvotes) {
            
            return upvotes - downvotes
        }
        
        return 0
    }
    
    func toAny() -> Any {
        
        return [
            
            "uuid": uuid,
            "time": time,
            "lat": lat,
            "long" : long,
            "text": text,
            "upvotes": upvotes,
            "downvotes" : downvotes,
            "user": user
            
        ]
    }
}
