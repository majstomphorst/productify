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
    var indexSend = Int()

    // MARK: - Outlets
    @IBOutlet weak var startFilterField: UITextField!
    @IBOutlet weak var endFilterField: UITextField!
    @IBOutlet weak var historyTableView: UITableView!

    
    // MARK: - Actions
    @IBAction func startFilterPress(_ sender: Any) {
        
        DatePickerDialog().show(title: "Picker", doneButtonTitle: "Done",
                                cancelButtonTitle: "Cancel",
                                datePickerMode: .date) { (date) in
            if let date = date {
                self.startFilter = Int((date.timeIntervalSince1970))
                self.startFilterField.text = date.description
            }
        }
        
        
    }
    
    @IBAction func endFilterPress(_ sender: Any) {
        
        DatePickerDialog().show(title: "Picker", doneButtonTitle: "Done",
                                cancelButtonTitle: "Cancel",
                                datePickerMode: .date) { (date) in
            if let date = date {
                self.endFilter = Int((date.timeIntervalSince1970))
                self.endFilterField.text = date.description
            }
        }
        
    }

    @IBAction func lookUp(_ sender: Any) {
        
        filterdActivities = [NSDictionary]()
        
        Database.database().reference().child(Fire.shared.userId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let keys = snapshot.value as? NSDictionary else {
                return
            }
            
            for key in keys.allKeys {
                
                let k = Int("\(key)")
        
                if k! > self.startFilter && k! < self.endFilter {
                    self.filterdActivities.append((keys[key] as? NSDictionary)!)
                }
            }
            
            self.historyTableView.reloadData()
            
            
        })
        
    }
    
    // MARK: - Navigation
    
    // sends the activity information to the conformation screen to be stored
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreInfoSegue" {
            let moreInfoVC = segue.destination as! MoreActivityInfoUIviewViewController

            moreInfoVC.activityInfo = filterdActivities[indexSend]
        }
    }
    
    
}


extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        
        cell.iconLabel.text = filterdActivities[indexPath.row]["iconLabel"] as? String
        cell.imagName = filterdActivities[indexPath.row]["iconLabel"] as? String
        cell.timeLabel.text = timeString(time: TimeInterval(filterdActivities[indexPath.row]["time"]! as! Int))
        
        return cell
    }
    
    // tels the table that every cell can de deleted
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // handels the delete actions
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            // bad ass type casting for reason
            let deletekey = "\(filterdActivities[indexPath.row]["key"] as! Int)"
            
            let reff = Database.database().reference().child(Fire.shared.userId).child(deletekey)
            
            reff.removeValue()
            filterdActivities = [NSDictionary]()
            self.historyTableView.reloadData()
    
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSend = indexPath.row
    }
    
    
}
