//
//  UploadFromAppViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 17/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit

protocol DataSendDelegate {
    func userDidEnterData(data: UIImage)
}

class UploadFromAppViewController: UIViewController {
    
    var delegate: DataSendDelegate? = nil
    var icons = [String]()
    
    override func viewDidLoad() {
        
        for i in 0 ... 5 {
            icons.append("\(i)")
        }
        
    }
    
     // MARK: - Navigation
     @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
     }

}

extension UploadFromAppViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! SelectIconCollectionViewCell
        
        cell.IconImage.image = UIImage(named: icons[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        print("didSelect \(indexPath)")

        let cell = collectionView.cellForItem(at: indexPath) as! SelectIconCollectionViewCell
        
        if let icon = cell.IconImage.image {
            delegate?.userDidEnterData(data: icon)
            self.dismiss(animated: true, completion: nil)
        } else {
            
            print("found nill")
        }
        
        
    }
    
    
    
}
