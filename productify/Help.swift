//
//  ViewController+Error.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 23/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 create's 
 - alert notifiaction
 - loading screen
 - schedules notification
 - user-friendly time stamp converter
*/


import Foundation
import UIKit
import UserNotifications
import UserNotificationsUI

extension UIViewController {
    
    /// this sets up a notification on a scheduled
    func scheduleNotification(timeinterval: Int) {
        
        
        // Define Actions
        let fruitAction = UNNotificationAction(identifier: "addFruit", title: "Add a piece of fruit", options: [])
        let vegiAction = UNNotificationAction(identifier: "addVegetable", title: "Add a piece of vegetable", options: [])
        
        // Add actions to a foodCategeroy
        let category = UNNotificationCategory(identifier: "foodCategory", actions: [fruitAction, vegiAction], intentIdentifiers: [], options: [])
        
        // Add the foodCategory to Notification Framwork
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeinterval), repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Awesome you are done!"
        content.body = "let log that activitie"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "foodCategory"
        
        
        let request = UNNotificationRequest(identifier: "foodNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { (error:Error?) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    /// This creates a alert message for the user to give them feedback to tel them,
    /// what is happening in the background especially our messages
    func alertUser(title: String, message: String) {
        
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    
    }
    
    /// Creating a time stamp voor the timer to display
    func timeString(time: TimeInterval) -> String {
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        
    }
    
    /// Display's a loading screen which you can trun on/off
    func setLoadingView(message: String) {
        
        // set up alert view
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)

        
        // give view constraints and property's
        let alertView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5,
                                                              width: 50,
                                                              height: 50))
        alertView.hidesWhenStopped = true
        alertView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        alertView.startAnimating();
        
        // create a subview to overlay current view
        alert.view.addSubview(alertView)
        
        // display laoding view
        present(alert, animated: true, completion: nil)
            
    }
    
    
}
