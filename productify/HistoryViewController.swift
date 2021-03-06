//
//  HistoryViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 19/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 Here you can select what history (start/end time) you want to see
 if you press on one you see more information about the activity
*/

import UIKit
import Firebase
import DatePickerDialog

class HistoryViewController: UIViewController {
    
    
    var activity = [ActivityInfo]()
    var filterdActivities = [NSDictionary]()
    var startFilter = 0
    var endFilter = 0
    var indexSend = Int()

    // MARK: - Outlets
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!

    
    // MARK: - Actions
    
    /// displays a datapicker
    @IBAction func startFilterPress(_ sender: Any) {
        
        DatePickerDialog().show(title: "Picker", doneButtonTitle: "Done",
                                cancelButtonTitle: "Cancel",
                                datePickerMode: .date) { (date) in
                                    
                                    
            if let date = date {
                self.startFilter = Int((date.timeIntervalSince1970))
                self.startButton.setTitle(date.description, for: .normal)
                
            }
        }
        
    }
    
    /// displays a dataPicker
    @IBAction func endFilterPress(_ sender: Any) {
        
        DatePickerDialog().show(title: "Picker", doneButtonTitle: "Done",
                                cancelButtonTitle: "Cancel",
                                datePickerMode: .date) { (date) in
                                    
                                    
            if let date = date {
                self.endFilter = Int((date.timeIntervalSince1970))
                self.endButton.setTitle(date.description, for: .normal)
            }
        }
        
    }
    
    /// this looks a every activity that the user has and if its between
    /// the start en end value it wil be saved
    @IBAction func lookUp(_ sender: Any) {
        
        filterdActivities = [NSDictionary]()
        
        Database.database().reference().child(Fire.share.userId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let keys = snapshot.value as? NSDictionary else {
                return
            }
            
            // looking at every key
            for key in keys.allKeys {
                
                // casting for reason 42
                let k = Int("\(key)")
                
                // filtering activitys
                if k! > self.startFilter && k! < self.endFilter {
                    
                    self.filterdActivities.append((keys[key] as? NSDictionary)!)
                }
            }
            // done realoding the view
            self.historyTableView.reloadData()
            
            
        })
        
    }
    
    // MARK: - Navigation
    
    /// sends the activity information to the conformation screen to be stored
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreInfoSegue" {
            
            let moreInfoVC = segue.destination as! MoreActivityInfoUIviewViewController

            moreInfoVC.activityInfo = filterdActivities[indexSend]
        }
    }
    
    
}
/*
 table view properties
*/
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    // how many cell's needed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdActivities.count
    }
    
    // concent the cell
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
            
            // bad ass type casting for reasons
            let deletekey = "\(filterdActivities[indexPath.row]["key"] as! Int)"
            
            let reff = Database.database().reference().child(Fire.share.userId).child(deletekey)
            
            reff.removeValue()
            filterdActivities = [NSDictionary]()
            self.historyTableView.reloadData()
    
        }
    }
    
    // tells what information has to be send to the next viecontroller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSend = indexPath.row
        performSegue(withIdentifier: "moreInfoSegue", sender: nil)
    }
    
    
}
