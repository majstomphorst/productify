//
//  ActivityInfo.swift
//  productify
//
//  Created by Maxim Stomphorst on 28/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import Foundation

struct ActivityInfo {
    var time: Int
    var iconLabel: String
    var todo: String
    var feeling: Int
    var haveDone: String
    var key: Int
    
    init() {
        self.time = Int()
        self.iconLabel = String()
        self.todo = String()
        self.feeling = Int()
        self.haveDone = String()
        self.key = Int()
    }
    
    /// for firebase to create a dictionary
    func getDictonary() -> [String : Any] {
        
        let activityDict = ["time": self.time,
                            "iconLabel": self.iconLabel,
                            "todo": self.todo,
                            "feeling": self.feeling,
                            "haveDone": self.haveDone,
                            "key": self.key] as [String : Any]
        
        return activityDict
    }
    
}
