//
//  HistoryViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 19/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController {
    
    
    var filterdActivities = [NSDictionary]()

    // MARK: - Outlets
    @IBOutlet weak var monthPicker: UIPickerView!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var weekMonthOutlet: UISegmentedControl!
    
    var row = 0
    var monthSelected = true
    
    var pickerData = ["January", "February", "March", "April",
                      "May", "June","July", "August",
                      "September", "October","November", "December"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Actions
    
    @IBAction func segmentation(_ sender: Any) {
        switch weekMonthOutlet.selectedSegmentIndex
        {
        case 0:
            
            self.pickerData = ["January", "February", "March", "April",
                              "May", "June","July", "August",
                              "September", "October","November", "December"]
            self.monthPicker.reloadAllComponents()
            
            self.monthSelected = true
            
            
        //show popular view
        case 1:
            self.pickerData = []
            
            for i in 1...52 {
                self.pickerData.append(String(format: "week %02i", i))
            }
            
            self.monthPicker.reloadAllComponents()
            self.monthSelected = false
            
        //show history view
        default:
            break;
        }
        
    }
    @IBAction func lookUp(_ sender: Any) {
        
        self.filterdActivities = [NSDictionary]()
        var filter = String()
        
        
        if self.monthSelected == true {
            filter = String(format: "month-%02i",row + 1)
        } else {
            filter = String(format: "week-%02i",row + 1)
        }
        
        
        Database.database().reference().child(Fire.shared.userId).observeSingleEvent(of: .value, with: { (snapshot) in

            guard let keys = snapshot.value as? NSDictionary else {
                return
            }
            
            // get a list of filterd key's where the activiies are stored
            var keysFilter = [String]()
            for key in keys.allKeys {
                if (key as! String).range(of: filter) != nil {
                    keysFilter.append(key as! String)
                    
                }
            }
            
            
            guard let activities = snapshot.value as? NSDictionary else {
                return
            }
            
            for key in keysFilter {
                self.filterdActivities.append((activities[key] as? NSDictionary)!)
            }
            

            self.historyTableView.reloadData()
            
            
        })
        
        
    }
    

}

extension HistoryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.row = row
    }
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        cell.iconLabel.text = (filterdActivities[indexPath.row]["iconLabel"] as! String)
        cell.imagName = (filterdActivities[indexPath.row]["iconLabel"] as! String)
        
        print(filterdActivities[indexPath.row])
        
        return cell
    }
    
    // tels the table that every cell can de deleted
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // handels the delete actions
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            print(filterdActivities[indexPath.row])
            
           
            
        }
    }
    
    
}
