//
//  EditIconViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 Here you can see what your labels are
 you can delete them 
 and with the add button (+) you can add one.
*/

import UIKit
import Firebase

class EditIconViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var iconEditTableView: UITableView!
    
    // the icons that you have
    var icons = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dataRef = Fire.share.dataRef
        
        dataRef = dataRef.child("pref/\(Fire.share.userId)")
        
        
        // collecting your icons from the database
        dataRef.queryOrderedByKey().observe(DataEventType.value, with:
            { (snapshot) in

            
                // empty icons no dubplicates
                self.icons = [NSDictionary]()
                
                guard let value = snapshot.value as? NSDictionary else {
                    return
                }
                
                // collect all you icons as dictionrys (iconUrl and IconLabel)
                for key in value.allKeys {
                    
                    self.icons.append(value[key] as! NSDictionary)
                    
                }
                
                
                // done relaod table
                DispatchQueue.main.async {
                    self.iconEditTableView.reloadData()
                }
            
            
        })

    }

    // MARK: - Navigation
    @IBAction func plus(_ sender: Any) { }
}


/*
 Handels the tableview options
*/
extension EditIconViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    /// returns the amount of cels needed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    /// returns what is displayed in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EditIconTableViewCell
        
        cell.nameLabel?.text = (icons[indexPath.row]["label"] as! String)
        cell.imageUrl = URL(string: icons[indexPath.row]["iconUrl"] as! String)
        
        return cell
        
    }
    
    /// tels the table that every cell can de deleted
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// handels the delete actions
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            Fire.share.deleteIconStorage(name: icons[indexPath.row]["label"] as! String)
            
        }
    }
    
    
    
}
