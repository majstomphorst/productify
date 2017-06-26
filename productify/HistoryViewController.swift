//
//  HistoryViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 19/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase
import DatePickerDialog

class HistoryViewController: UIViewController {
    
    
    var filterdActivities = [NSDictionary]()
    var startFilter = 0
    var endFilter = 0

    // MARK: - Outlets
    @IBOutlet weak var startFilterField: UITextField!
    @IBOutlet weak var endFilterField: UITextField!
    
    
    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Actions
    @IBAction func startFilterPress(_ sender: Any) {
        
        DatePickerDialog().show(title: "DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            self.startFilter = Int((date?.timeIntervalSince1970)!)
            self.startFilterField.text = date!.description
        }
        
    }
    @IBAction func endFilterPress(_ sender: Any) {
        
        DatePickerDialog().show(title: "DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            self.endFilter = Int((date?.timeIntervalSince1970)!)
            self.endFilterField.text = date?.description
        }
        
        
    }

    @IBAction func lookUp(_ sender: Any) {
        
        // startDateField
        
        
        Database.database().reference().child(Fire.shared.userId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let keys = snapshot.value as? NSDictionary else {
                return
            }
            
            
            for key in keys.allKeys {
                
                let k = Int("\(key)")
                
                if k! > self.startFilter || k! < self.endFilter {
                    
                    self.filterdActivities.append((keys[key] as? NSDictionary)!)
                }
            }
            
            self.historyTableView.reloadData()
            
            
        })
        
    }
    
  
    
    
    
    
        
        
//    Database.database().reference().child(Fire.shared.userId).observeSingleEvent(of: .value, with: { (snapshot) in
//
//        guard let keys = snapshot.value as? NSDictionary else {
//            return
//        }
//        
//        // get a list of filterd key's where the activiies are stored
//        var keysFilter = [String]()
//        for key in keys.allKeys {
//            if (key as! String).range(of: filter) != nil {
//                keysFilter.append(key as! String)
//                
//            }
//        }
//        
//        
//        guard let activities = snapshot.value as? NSDictionary else {
//            return
//        }
//        
//        for key in keysFilter {
//            self.filterdActivities.append((activities[key] as? NSDictionary)!)
//        }
//        
//
//        self.historyTableView.reloadData()
//        
//        
//    })
    
        
    

}


extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        
        cell.iconLabel.text = filterdActivities[indexPath.row]["iconLabel"] as? String
        
        return cell
    }
    
    // tels the table that every cell can de deleted
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // handels the delete actions
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            // print(filterdActivities[indexPath.row])
            
           
            
        }
    }
    
    
}
