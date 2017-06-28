//
//  SigninViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class SigninViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        
        // setting up UI
        emailField.isEnabled = true
        passwordField.isEnabled = true
        
    }

    // MARK: - Actions
    @IBAction func signinButton(_ sender: Any) {
        
        setLoadingView(onOff: true, message: "Signin...")
        
        // collecting info
        let email = emailField.text!
        let password = passwordField.text!
        
        // chaning UI
        emailField.text = ""
        emailField.isEnabled = false
        passwordField.text = ""
        passwordField.isEnabled = false
        
        // signing the user
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, error) in
            
            // if error
            if error != nil{
             
                // Alert user
                self.alertUser(title: "Signin error!",
                               message: "System report: /r/n\(error!.localizedDescription)")
                
            // no error
            } else {
                
                // save the userId
                Fire.share.userId = "\(user!)"
                
                self.setLoadingView(onOff: false)
                // send user to mainViewController
                self.dismiss(animated: true, completion: nil)
            }
            
            
            
        }
        
    }


}
