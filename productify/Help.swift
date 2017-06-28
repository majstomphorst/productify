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

extension UIViewController {
    
    /// this sets up a notification on a scheduled
    func setNotification(countDown: Double, title: String, body: String) {
        
        // define action for notifications
        let timesUp = UNNotificationAction(identifier: "title",
                                           title: "body",
                                           options: [])
        
        // add action to timesUp category
        let category = UNNotificationCategory(identifier: "timesUp",
                                              actions: [timesUp],
                                              intentIdentifiers: [],
                                              options: [])
        
        // add the timesUp category to the notification framework
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        // Alerts user after timeInterval (in seconds)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: countDown,
                                                        repeats: false)
        
        // creating content of notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.body =  body
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "timesUp"
        
        let request = UNNotificationRequest(identifier: "time is up",
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        UNUserNotificationCenter.current().add(request) {
            (error) in
            
            if let error = error {
                print(error.localizedDescription)
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
