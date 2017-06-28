//
//  AppDelegate.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let vc = MainViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // starting firebase
        FirebaseApp.configure()
        
        // send a request to allow notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (authorized: Bool, error) in
            
            if !authorized  {
              print("no auth notifications")
            }
            
        }
        
        // Define Actions
        let fruitAction = UNNotificationAction(identifier: "addFruit", title: "Add a piece of fruit", options: [])
        let vegiAction = UNNotificationAction(identifier: "addVegetable", title: "Add a piece of vegetable", options: [])
        
        
        // Add actions to a foodCategeroy
        let category = UNNotificationCategory(identifier: "foodCategory", actions: [fruitAction, vegiAction], intentIdentifiers: [], options: [])
        
        // Add the foodCategory to Notification Framwork
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        return true
    }
    
    func scheduleNotification() {
        
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Stay Health"
        content.body = "Just a reminder to eat your favourtite healty food."
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




}

