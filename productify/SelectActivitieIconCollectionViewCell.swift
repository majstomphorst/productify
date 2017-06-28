//
//  SelectActivitieIconCollectionViewCell.swift
//  productify
//
//  Created by Maxim Stomphorst on 19/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Kingfisher

class SelectActivitieIconCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    
    // if the value of imageUrl changes to the folowing
    var imageUrl: URL? {
        didSet {
            
            let url = URL(string: (imageUrl?.absoluteString)!)
            self.iconImage.kf.setImage(with: url)
            
            
            
        }
    }
    
}
