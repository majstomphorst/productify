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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // starting firebase
        FirebaseApp.configure()
        
        // send a request to allow notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (authorized, error) in
            
            if !authorized  {
              print("no auth notifications")
            }
            
        }
        
        // define action for notifications
        let timesUp = UNNotificationAction(identifier: "timesUp", title: "time is up1", options: [])
        
        // add action to timesUp category
        let category = UNNotificationCategory(identifier: "timesUp", actions: [timesUp], intentIdentifiers: [], options: [])
        
        // add the timesUp category to the notification framework
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        return true
    }
    
    func scheduleNotification() {
        
        // Alerts user after timeInterval (in seconds) it doest not repeat
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // creating content of notification
        let content = UNMutableNotificationContent()
        content.title = "Time is up!"
        content.body = "Body text!"
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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

