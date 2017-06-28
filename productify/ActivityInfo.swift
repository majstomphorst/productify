//
//  ActivityInfo.swift
//  productify
//
//  Created by Maxim Stomphorst on 28/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 This struct house the activity information
 - time = the time in seconds that the user has worked on a task
 - iconLabel =  the name associated with the icon
 - todo = a description of what user wanted to do
 - feeling = keep track of how the activity went -1 bad 1 = fine 2 = good
   0 is nil if the user doesnt give a value
 - haveDone: a description of what the user really did in the spend time
 - key: The value of its note (easy for deletion of the activity)
 */



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
    
    init(dict: NSDictionary) {
        self.time = dict["time"] as! Int
        self.iconLabel = dict["iconLabel"] as! String
        self.todo = dict["todo"] as! String
        self.feeling = dict["Feeling"] as! Int
        self.haveDone = dict["havedone"] as! String
        self.key = dict["key"] as! Int
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
