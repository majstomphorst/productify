//
//  Helper.swift
//  productify
//
//  Created by Maxim Stomphorst on 26/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension UIViewController {
    
    /*
     This creates a alert message for the user to give them feedback to tel them,
     what is happening in the background especially our messages
     */
    func alertUser(title: String, message: String) {
        
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}

class Notification {
    
    /// this sets up a notification that wil be scheduled
    func schedule(countDown: Double, title: String, body: String) {
        
        // define action for notifications
        let timesUp = UNNotificationAction(identifier: "timesUp", title: "Let's save you're awesome work!", options: [])
        
        // add action to timesUp category
        let category = UNNotificationCategory(identifier: "timesUp", actions: [timesUp], intentIdentifiers: [], options: [])
        
        // add the timesUp category to the notification framework
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        // Alerts user after timeInterval (in seconds) it doest not repeat
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: countDown, repeats: false)
        
        // creating content of notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.body =  body
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "timesUp"
        
        let request = UNNotificationRequest(identifier: "time is up notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    
}
