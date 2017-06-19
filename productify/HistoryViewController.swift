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

    // MARK: - Outlets
    @IBOutlet weak var monthPicker: UIPickerView!
    
    
    var row = 0
    
    let pickerData = ["January", "February", "March", "April",
                      "May", "June","July", "August",
                      "September", "October","November", "December"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func lookUp(_ sender: Any) {
        
        let month = String(format: "%02i",row + 1)
        
        Database.database().reference().child(Fire.shared.userId).observeSingleEvent(of: .value, with: { (snapshot) in

            guard let activity = snapshot.value as? NSDictionary else {
                return
            }
            
            for key in activity.allKeys{
                
                if (key as! String).range(of: "month-\(month)") != nil {
                    print(key)
                }
                
                
            }
            
            
            
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
        return pickerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        cell.iconLabel.text = pickerData[indexPath.row]
        
        return cell
    }
    
    
}
