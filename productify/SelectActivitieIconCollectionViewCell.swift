//
//  SelectActivitieIconCollectionViewCell.swift
//  productify
//
//  Created by Maxim Stomphorst on 19/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit

class SelectActivitieIconCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    
    // if the value of imageUrl changes to the folowing
    var imageUrl: URL? {
        didSet {
            
            self.iconImage.image = nil
            
            // start a task on a second thread, go to the imageUrl and extracts image data
            let task = URLSession.shared.dataTask(with: imageUrl!) { (data, response, error) in
                
                if error != nil {
                    
                } else {
                    if let data = data {
                        
                        // on the main thread
                        DispatchQueue.main.async {
                            // Assigning image data to Image placeholder
                            self.iconImage.image = UIImage(data: data)
                        }
                    }
                }
            }
            task.resume()
            
            
        }
    }
    
}
