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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
    
    
    // if a image is selected with the image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.IconImage.image = image
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
