//
//  MainViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        // Check if user is signin or not
        if let userId = Auth.auth().currentUser?.uid {
            print(userId)
            
            Fire.shared.userId = userId
            // user is signin
        } else {
            // user is not signin
            print("segue")
            performSegue(withIdentifier: "signinSegue", sender: nil)
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func button(_ sender: Any) {
        
        print("hello?")
        
        do {
            try Auth.auth().signOut()
            
            self.performSegue(withIdentifier: "signinSegue", sender: nil)
            
            // if error this send a alert to the user with the reason why
        } catch {
            
            // alertUser(title: "logout went wrong", message: error.localizedDescription)
        }
    }
    
    
    // MARK: - Navigation
    @IBAction func returnToMainView(segue: UIStoryboardSegue) {}


}
