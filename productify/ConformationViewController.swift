//
//  ConformationViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 19/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit

class ConformationViewController: UIViewController {
    
    var activity = ActivityInfo()
    
    @IBOutlet weak var mwaButton: UIButton!
    @IBOutlet weak var fineButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var haveDoneField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions

    @IBAction func mwaPress(_ sender: Any) {
        activity.feeling = -1
        mwaButton.isSelected = true
        fineButton.isSelected = false
        goodButton.isSelected = false
    }
    
    @IBAction func FinePress(_ sender: Any) {
        activity.feeling = 1
        mwaButton.isSelected = false
        fineButton.isSelected = true
        goodButton.isSelected = false
    }
    
    @IBAction func goodPress(_ sender: Any) {
        activity.feeling = 2
        mwaButton.isSelected = false
        fineButton.isSelected = false
        goodButton.isSelected = true
    }
    
    @IBAction func savePress(_ sender: Any) {
        
        if haveDoneField.text != nil {
            activity.haveDone = haveDoneField.text!
        }
        
        print(activity)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
