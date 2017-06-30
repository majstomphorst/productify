//
//  MoreActivityInfoUIviewViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 27/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 Displays more information about the activity
*/

import UIKit
import Firebase
import Kingfisher

class MoreActivityInfoUIviewViewController: UIViewController {
    
    // the activity that is gowing to be displayed
    // this info is send from HistoryVC to this view
    var activityInfo = NSDictionary()
    
    // Mark: - Outlets
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var todoField: UITextView!
    @IBOutlet weak var haveDoneField: UITextView!
    
    override func viewDidAppear(_ animated: Bool) {
        
        // setup UI
        iconLabel.text = activityInfo["iconLabel"] as? String
        time.text = timeString(time: TimeInterval(activityInfo["time"] as! Int))
        todoField.text = activityInfo["todo"] as? String
        haveDoneField.text = activityInfo["haveDone"] as? String
        
        
        let storRef = Fire.share.storRef
        
        // Create a reference to the file you want to download
        let refStore = storRef.child(Fire.share.userId).child("\(iconLabel.text!).png")
        
        refStore.getMetadata { (metadata, error) in
            
            DispatchQueue.main.async {
                // laods the image
                self.iconImage.kf.setImage(with: metadata?.downloadURL())

            }
        }
        
    }


}
