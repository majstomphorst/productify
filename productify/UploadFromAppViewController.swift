//
//  UploadFromAppViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 17/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 provides icon that a user can use for there labels.
 it creates: 
 - a collection view that displays al the default icon
   a user can select one that is can send back to the upload view
*/

import UIKit

/// provides a way to send data back to UploadViewController
protocol DataSendDelegate {
    func userDidEnterData(data: UIImage)
}

class UploadFromAppViewController: UIViewController {
    
    var delegate: DataSendDelegate? = nil
    
    // a (bad) way of selecting the default icons in the icon folder
    var icons = ["0","1","2","3","4"]
    
    
     // MARK: - Navigation
     @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
     }

}


/*
 Controls the collection view to display the icons
*/
extension UploadFromAppViewController: UICollectionViewDelegate,
                                       UICollectionViewDataSource {
    
    /// number of cells needed
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    /// content of the cell (icon)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! SelectIconCollectionViewCell
        
        cell.IconImage.image = UIImage(named: icons[indexPath.row])
        
        return cell
    }
    
    
    /// if a icon is selected this sends the image via the protocal back to
    /// the upload view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       

        let cell = collectionView.cellForItem(at: indexPath) as! SelectIconCollectionViewCell
        
        guard let icon = cell.IconImage.image else {
            return
        }
        
        delegate?.userDidEnterData(data: icon)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
