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
        headerLabel.text = "Sign in"
        emailField.isEnabled = true
        passwordField.isEnabled = true
        
    }
    

    // MARK: - Actions
    @IBAction func signinButton(_ sender: Any) {
        
        
        // collecting info
        let email = emailField.text!
        let password = passwordField.text!
        
        
        // chaning UI
        headerLabel.text = "Signin please wait."
        emailField.text = ""
        emailField.isEnabled = false
        passwordField.text = ""
        passwordField.isEnabled = false
        
        
        // signing the user
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            // if error
            if error != nil{
             
                // Alert user
                
            // no error
            } else {
                
                // user most be present else error has to run
                // save the userId
                Fire.shared.userId = "\(user!)"
                
                // send user to mainViewController
                self.dismiss(animated: true, completion: nil)
            }
            
            
            
        }
        
    }


}
