//
//  ViewController+Error.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 23/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 This extension create's a convincent way to create alert notifiaction too alert the user
 if any error occurs. 
*/


import Foundation
import UIKit


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
    
    /// Creating a time stamp voor the timer to display
    func timeString(time: TimeInterval) -> String {
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        
    }
    
    func loading(onOff: Bool, message: String) {
        
        if onOff {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            
        } else {
            dismiss(animated: false, completion: nil)
        }
    
    }
    
    
}
