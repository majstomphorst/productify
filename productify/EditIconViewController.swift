//
//  EditIconViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class EditIconViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var iconEditTableView: UITableView!
    
    var henk = [NSDictionary]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        Database.database().reference().child("pref/\(Fire.shared.userId)").observe(DataEventType.value, with: { (snapshot) in
            
            if let value = snapshot.value as? NSDictionary {
                
                for key in value.allKeys {
                    
                    self.henk.append(value[key] as! NSDictionary)
                    
                }
                
            }
            
            DispatchQueue.main.async {
                print(self.henk)
                
                self.iconEditTableView.reloadData()
            }
            
            
            
            
        })
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    @IBAction func plus(_ sender: Any) {
        
        
        
    }
}

extension EditIconViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(henk.count)
        return henk.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EditIconTableViewCell
        
        cell.nameLabel.text = henk[indexPath.row]["label"] as! String
        
        return cell
        
    }
    
}
