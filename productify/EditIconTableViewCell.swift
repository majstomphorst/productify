//
//  EditIconTableViewCell.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit

class EditIconTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var iconImage: UIImageView?
    @IBOutlet weak var nameLabel: UILabel!
    
    // if the value of imageUrl changes to the folowing
    var imageUrl: URL? {
        didSet {
            
            
            // start a task on a second thread, go to the imageUrl and extracts image data
            let task = URLSession.shared.dataTask(with: imageUrl!) { (data, response, error) in
                
                if error != nil {
                    
                } else {
                    if let data = data {
                        
                        // on the main thread
                        DispatchQueue.main.async {
                            // Assigning image data to Image placeholder
                            self.iconImage?.image = UIImage(data: data)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
}
