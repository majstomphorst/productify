//
//  MoreActivityInfoUIviewViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 27/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 
*/

import UIKit
import Firebase

class MoreActivityInfoUIviewViewController: UIViewController {
    
    var activityInfo = NSDictionary()
    
    // Mark: - Outlets
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var todoField: UITextView!
    @IBOutlet weak var haveDoneField: UITextView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        iconLabel.text = activityInfo["iconLabel"] as? String
        time.text = timeString(time: TimeInterval(activityInfo["time"] as! Int))
        todoField.text = activityInfo["todo"] as? String
        haveDoneField.text = activityInfo["haveDone"] as? String
        
        
        // Create a reference to the file you want to download
        let storRef = Fire.share.storRef
        
        
        storRef.child(Fire.share.userId).child("\(iconLabel.text!).png")
        
        storRef.getMetadata {
            (metadata, error) in
            
            DispatchQueue.main.async {
                
                self.iconImage.kf.setImage(with: metadata?.downloadURL())
                
            }
            
        }
    }
    




}
