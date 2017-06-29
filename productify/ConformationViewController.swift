//
//  ConformationViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 19/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 
*/

import UIKit
import Firebase

class ConformationViewController: UIViewController {
    
    var activity = ActivityInfo()
    
    @IBOutlet weak var mwaButton: UIButton!
    @IBOutlet weak var fineButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var haveDoneField: UITextView!
    
    // MARK: - Actions
    
    /// saves user's feeling and update's the UI
    @IBAction func mwaPress(_ sender: Any) {
        selectButton(mwa: true, fine: false, good: false)
    }
    
    @IBAction func FinePress(_ sender: Any) {
        selectButton(mwa: false, fine: true, good: false)
    }
    
    @IBAction func goodPress(_ sender: Any) {
        selectButton(mwa: false, fine: false, good: true)
    }
    
    
    // MARK: - Actions
    ///
    @IBAction func savePress(_ sender: Any) {
        
        if haveDoneField.text != nil {
            activity.haveDone = haveDoneField.text!
        }
        
        // making it a int because firebase doesnt want '.' value's in the key
        let timeStamp = Int(Date().timeIntervalSince1970)
        
        activity.key = timeStamp
        
        var dataRef = Fire.share.dataRef
        dataRef = dataRef.child(Fire.share.userId).child(String(timeStamp))
        
        // converts ActivityStruct in a dictionary
        let activityDict = activity.getDictonary()
        
        // save the activity to the database
        dataRef.updateChildValues(activityDict) {
            (error, DatabaseReference) in
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Function
    
    func selectButton(mwa: Bool, fine: Bool, good: Bool) {
        if mwa {
            activity.feeling = -1
        }
        
        if fine {
            activity.feeling = 1
        }
        
        if good {
            activity.feeling = 2
        }
        
        mwaButton.isSelected = mwa
        fineButton.isSelected = fine
        goodButton.isSelected = good
    }
    

}
