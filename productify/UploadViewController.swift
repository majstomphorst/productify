//
//  UploadViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var IconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // making the ui nice
        IconImage.layer.borderWidth = 1
        IconImage.layer.masksToBounds = false
        IconImage.layer.borderColor = UIColor.white.cgColor
        IconImage.layer.cornerRadius = IconImage.frame.height / 2
        IconImage.clipsToBounds = true
        popupView.layer.cornerRadius = 15
        saveButton.layer.cornerRadius = 10
        
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveButtonPress(_ sender: Any) {
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        print("taptap")
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
