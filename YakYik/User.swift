//
//  User.swift
//  YakYik
//
//  Created by Admin on 3/22/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    
    var uuid: String
    var karma: Int
    
    init(uuid: String, karma: Int = 0) {
        
        self.uuid = uuid
        self.karma = karma
    }
    
    struct userDefault {
        
        static let uuid = "UserUUID"
        static let karma = "UserKarma"
    }
    
    func toAny() -> Any {
        
        return [
            
            "uuid": uuid,
            "karma": String(karma)
        ]
    }
    
    func increaseKarma() {
        
        karma += 10
        
        Defaults.set(karma, forKey: userDefault.karma)
    }
}
