//
//  HistoryTableViewCell.swift
//  productify
//
//  Created by Maxim Stomphorst on 19/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class HistoryTableViewCell: UITableViewCell {

    //Mark: - Outlets
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // if the value of imageUrl changes to the folowing
    var imagName: String? {
        didSet {
            
            // Create a reference to the file you want to download
            let refStore = Storage.storage().reference().child(Fire.shared.userId).child("\(imagName!).png")
            
            refStore.getMetadata { (metadata, error) in
                
                DispatchQueue.main.async {

                    self.iconImage.kf.setImage(with: metadata?.downloadURL())
                    
                    
                }
            }
            
            
        }
    }
    

}
