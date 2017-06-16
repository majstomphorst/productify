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
    @IBOutlet weak var iconNameLabel: UITextField!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // making the ui nice
        iconImage.layer.borderWidth = 1
        iconImage.layer.masksToBounds = false
        iconImage.layer.borderColor = UIColor.white.cgColor
        iconImage.layer.cornerRadius = iconImage.frame.height / 2
        iconImage.clipsToBounds = true
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
        
        if iconNameLabel.text == "" {
            alertUser(title: "no icon label", message: "provide a label")
            return
        }
        
        let icon = iconImage.image!
        let label = iconNameLabel.text!
        
        Fire.shared.storeIcon(icon: icon, label: label)
        
        
        
        self.dismiss(animated: true, completion: nil)
    
    }

    // MARK: - Navigation
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        
        // Create the action sheet
        let myActionSheet = UIAlertController(title: "Upload options", message: "How would you like to upload?", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // blue action button
        let upload = UIAlertAction(title: "Upload From Camararoll", style: UIAlertActionStyle.default) { (action) in
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            self.present(picker, animated: true, completion: nil)
            
        }
        
        // red action button
        let storages = UIAlertAction(title: "Pick one from the app", style: UIAlertActionStyle.default) { (action) in
            
            self.alertUser(title: "no implementation yet", message: "to bad")
        }
        
        // cancel action button
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) in
            print("Cancel action button tapped")
        }
        
        // add action buttons to action sheet
        myActionSheet.addAction(upload)
        myActionSheet.addAction(storages)
        myActionSheet.addAction(cancel)
        
        // send user to the uiImage picerk view
        self.present(myActionSheet, animated: true, completion: nil)
        
    }
    
    
    /// if a image is selected with the image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.iconImage.image = image
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
