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
            
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            refStore.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if error != nil {
                    // Uh-oh, an error occurred!
                } else {
                    // Data for "images/island.jpg" is returned
                    self.iconImage.image = UIImage(data: data!)
                }
            }
            
        }
    }
    

}
