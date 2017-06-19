//
//  ConformationViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 19/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class ConformationViewController: UIViewController {
    
    var activity = ActivityInfo()
    
    @IBOutlet weak var mwaButton: UIButton!
    @IBOutlet weak var fineButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var haveDoneField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions

    @IBAction func mwaPress(_ sender: Any) {
        activity.feeling = -1
        mwaButton.isSelected = true
        fineButton.isSelected = false
        goodButton.isSelected = false
    }
    
    @IBAction func FinePress(_ sender: Any) {
        activity.feeling = 1
        mwaButton.isSelected = false
        fineButton.isSelected = true
        goodButton.isSelected = false
    }
    
    @IBAction func goodPress(_ sender: Any) {
        activity.feeling = 2
        mwaButton.isSelected = false
        fineButton.isSelected = false
        goodButton.isSelected = true
    }
    
    @IBAction func savePress(_ sender: Any) {
        
        if haveDoneField.text != nil {
            activity.haveDone = haveDoneField.text!
        }
        
        let timeStamp = getCurrentTime()
        
        let reff = Database.database().reference().child(Fire.shared.userId).child(timeStamp)
    
        let activityDict = ["time": activity.time,
                            "iconLabel": activity.iconLabel,
                            "todo": activity.todo,
                            "feeling": activity.feeling,
                            "haveDone": activity.haveDone,] as [String : Any]
        
        reff.updateChildValues(activityDict) { (error, DatabaseReference) in
            
        }
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /// a way to get a time stamp 
    func getCurrentTime() -> String {
        
        let date = NSDate()
        let calendar = NSCalendar.current
        
        let hours = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        let seconds = calendar.component(.second, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let year = calendar.component(.year, from: date as Date)
        let week = calendar.component(.weekOfYear, from: date as Date)
        
        return String(format: "hour-%02i:minutes-%02i:seconds-%02i:day-%02i:week-%02i:month-%02i:year-%04i",
                      hours, minutes, seconds, day, week, month, year)
        
        
        
        

    }

}
