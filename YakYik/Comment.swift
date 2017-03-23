//
//  Comment.swift
//  YakYik
//
//  Created by Admin on 3/22/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation

class Comment: NSObject {
    
    var uuid: String
    var user: String
    var time: String
    var text: String
    
    init?(uuid: String, user: String, time: String, text: String) {
        
        self.uuid = uuid
        self.user = user
        self.time = time
        self.text = text
    }
    
    func toAny() -> Any {
        
        return [
            
            "uuid": uuid,
            "user": user,
            "time": time,
            "text": text
            
        ]
    }
}
