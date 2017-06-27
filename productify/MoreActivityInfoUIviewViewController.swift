//
//  MoreActivityInfoUIviewViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 27/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class MoreActivityInfoUIviewViewController: UIViewController {
    
    var activityInfo = NSDictionary()

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var todoField: UITextView!
    @IBOutlet weak var haveDoneField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconLabel.text = activityInfo["iconLabel"] as? String
        time.text = timeString(time: activityInfo["time"] as! Int)
        todoField.text = activityInfo["todo"] as? String
        haveDoneField.text = activityInfo["haveDone"] as? String
        
        
        // Create a reference to the file you want to download
        let refStore = Storage.storage().reference().child(Fire.shared.userId).child("\(iconLabel.text!).png")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        refStore.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                self.iconImage.image = UIImage(data: data!)
            }
        }
        
        

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Creating a time stamp voor the timer to display
    func timeString(time:Int) -> String {
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        
    }


}
