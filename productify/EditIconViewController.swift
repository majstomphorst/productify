//
//  EditIconViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 
*/

import UIKit
import Firebase

class EditIconViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var iconEditTableView: UITableView!
    
    var henk = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dataRef = Fire.share.dataRef
        dataRef = dataRef.child("pref/\(Fire.share.userId)")
        
        dataRef.queryOrderedByKey().observe(DataEventType.value, with:
            { (snapshot) in
            
            self.henk = [NSDictionary]()
            
            if let value = snapshot.value as? NSDictionary {
                
                for key in value.allKeys {
                    
                    self.henk.append(value[key] as! NSDictionary)
                    
                }
                
            }
            
            DispatchQueue.main.async {
                self.iconEditTableView.reloadData()
            }
            
            
        })

    }

    // MARK: - Navigation
    @IBAction func plus(_ sender: Any) { }
}


/*
//
*/
extension EditIconViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    // returns the amount of cels needed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return henk.count
    }
    
    // returns what is displayed in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EditIconTableViewCell
        
        cell.nameLabel?.text = (henk[indexPath.row]["label"] as! String)
        cell.imageUrl = URL(string: henk[indexPath.row]["iconUrl"] as! String)
        
        return cell
        
    }
    
    // tels the table that every cell can de deleted
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // handels the delete actions
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            Fire.share.deleteIconStorage(name: henk[indexPath.row]["label"] as! String)
            
        }
    }
    
    
    
}
