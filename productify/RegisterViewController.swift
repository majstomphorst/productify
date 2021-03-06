//
//  RegisterViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 controls the register proces
 - user wants register is succes:
 -- send to main view
 
 - user wants to sign in:
 -- send to sign in view
 */

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var password2Field: UITextField!
    
    // MARK: - Actions
    
    @IBAction func registerButton(_ sender: Any) {
        
        setLoadingView(message: "registration...")
        
        // collect user input
        let email = emailField.text!
        let password = passwordField.text!
        
        // check user input
        if passwordField.text! == passwordField.text! {
            alertUser(title: "no password", message: "Give me password!")
        }
        
        // registerting the user
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            // if error
            if error != nil {
                
                self.alertUser(title: "Registraion error!",
                               message: "System report: /r/n\(error!.localizedDescription)")
                
            } else {
                
                // user most be present else error has to run
                // save the userId
                Fire.share.userId = "\(user!)"
                
                // save the presenting ViewController
                let registerView: UIViewController = self.presentingViewController!
                self.dismiss(animated: true) {
                    // go back to MainMenuView as the eyes of the user
                    registerView.dismiss(animated: true, completion: nil)
                }
            }
            
        }

    }
    
    @IBAction func toSignin(_ sender: Any) {
        
        // Sender user back to sigin screen
        dismiss(animated: true, completion: nil)
    }


}
