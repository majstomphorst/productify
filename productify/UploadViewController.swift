//
//  UploadViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 
*/

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
    }

    // MARK: - Actions
    
    /// store's the icon in the firebase storage (and database)
    @IBAction func SaveButtonPress(_ sender: Any) {
        
        // check for a label text
        if iconNameLabel.text == "" {
            alertUser(title: "no icon label", message: "provide a label")
            return
        }
        
        // collect information
        let icon = iconImage.image!
        let label = iconNameLabel.text!
        
        // saves the information to the storage and places a record in database
        Fire.share.storeIcon(icon: icon, label: label)
        
        // send user back to edit view
        self.dismiss(animated: true, completion: nil)
    
    }

    // MARK: - Navigation

    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

/*
 Controls the image Picker
*/
extension UploadViewController: UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate {
    
    /// creates upload options if user presses on icon
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        
        // Create the action sheet
        let sheet = UIAlertController(title: "Upload options",
                                      message: "How would you like to upload?",
                            preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // upload from camerarol button
        let upload = UIAlertAction(title: "Upload From Camararoll",
                                   style: UIAlertActionStyle.default) {
            (action) in
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            self.present(picker, animated: true, completion: nil)
        }
        
        // upload from app button
        let storages = UIAlertAction(title: "Pick one from the app",
                                     style: UIAlertActionStyle.default) {
            (action) in
            
            self.performSegue(withIdentifier: "uploadFromApp", sender: nil)
        }
        
        // cancel button
        let cancel = UIAlertAction(title: "Cancel",
                                   style: UIAlertActionStyle.cancel) {
            (action) in
        }
        
        // add action buttons to action sheet
        sheet.addAction(upload)
        sheet.addAction(storages)
        sheet.addAction(cancel)
        
        // pressent the created action sheet
        self.present(sheet, animated: true, completion: nil)
    }
    
    
    /// if a image is selected with the image picker
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info:
        [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.iconImage.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}


/*
 This provides a way to recieve information from the UploadFromAppViewController
 The other part of is functon is locaede in pick from app view
*/
extension UploadViewController: DataSendDelegate {
    
    func userDidEnterData(data: UIImage) {
        self.iconImage.image = data
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "uploadFromApp" {
            let sendingVC: UploadFromAppViewController = segue.destination as! UploadFromAppViewController
            sendingVC.delegate = self
        }
    }
    
}
