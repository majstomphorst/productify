//
//  UploadFromAppViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 17/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit

protocol DataSendDelegate {
    func userDidEnterData(data: String)
}

class UploadFromAppViewController: UIViewController {
    
    var delegate: DataSendDelegate? = nil
    
    
    // MARK: - Navigation
     @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
     }

}

extension UploadFromAppViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! SelectIconCollectionViewCell
        
        cell.IconImage.image = UIImage(named: "1")
        
        print("hey")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        print("didSelect \(indexPath)")
    
        if delegate != nil {
            let data = "send me and print me!"
            
            delegate?.userDidEnterData(data: data)
            
            
        }
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! SelectIconCollectionViewCell
    
    }
    
    
    
}
