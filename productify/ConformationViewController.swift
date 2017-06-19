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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("conformationSegue")
        print(activity)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions

    @IBAction func mwaPress(_ sender: Any) {
    }
    
    @IBAction func FinePress(_ sender: Any) {
    }
    
    @IBAction func goodPress(_ sender: Any) {
    }
    @IBAction func savePress(_ sender: Any) {
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
