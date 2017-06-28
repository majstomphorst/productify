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
        
        // making it a int because firebase doesnt want '.' value's in the key
        let timeStamp = Int(Date().timeIntervalSince1970)
        
        activity.key = timeStamp
        
        
        
        var reff = Database.database().reference()
        reff = reff.child(Fire.share.userId).child(String(timeStamp))
    
        let activityDict = activity.getDictonary()
        
        reff.updateChildValues(activityDict) { (error, DatabaseReference) in
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
