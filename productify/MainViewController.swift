//
//  MainViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

struct ActivityInfo {
    var time: Int
    var iconLabel: String
    var todo: String
    var feeling: Int
    var haveDone: String
    
    init() {
        self.time = Int()
        self.iconLabel = String()
        self.todo = String()
        self.feeling = Int()
        self.haveDone = String()
    }
    
}


class MainViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var timeLabel: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var activitySelector: UICollectionView!
    @IBOutlet weak var todoField: UITextView!
    
    var selectedItem: IndexPath?
    
    // timer requirements
    var timer = Timer()
    var countseconds = Int()
    var countRunning = false
    var countPauzed = false
    
    var sjaak = [NSDictionary]()
    
    var activity = ActivityInfo()
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Check if user is signin or not
        if let userId = Auth.auth().currentUser?.uid {
            
            // save userId for later use
            Fire.shared.userId = userId
            
            Database.database().reference().child("pref/\(Fire.shared.userId)").queryOrderedByKey().observe(DataEventType.value, with: { (snapshot) in
                
                self.sjaak = [NSDictionary]()
                
                if let value = snapshot.value as? NSDictionary {
                    
                    for key in value.allKeys {
                        
                        self.sjaak.append(value[key] as! NSDictionary)
                        
                    }
                    
                }
                
                // reload the activity selector on main thread
                DispatchQueue.main.async {
                    self.activitySelector.reloadData()
                }
                
                
            })
            
        } else {
            
            // user is not signin send them to the sigin page
            performSegue(withIdentifier: "signinSegue", sender: nil)
        }
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func next(_ sender: Any) {
        
        if todoField.text != nil {
            activity.todo = todoField.text!
        }
        
        self.performSegue(withIdentifier: "conformationSegue", sender: nil)
    }
    
    // signs a user out and sends them to the sigin page
    @IBAction func signoutPress(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signinSegue", sender: nil)
            
        } catch {
            
            // if error this send a alert to the user with the reason why
            alertUser(title: "logout went wrong", message: error.localizedDescription)
        }
        
    }
    
    @IBAction func startButton(_ sender: Any) {
        
        if startButton.currentTitle == "Start" {
            
            // collect information for database
            activity.time = Int(timePicker.countDownDuration)
            
            startButton.setTitle("Pauze", for: UIControlState .normal)
            cancelButton.isEnabled = true
            timePicker.isEnabled = false
            
            start(seconds: Int(timePicker.countDownDuration))
            
        } else if startButton.currentTitle == "Pauze" {
            
            self.timer.invalidate()
            startButton.setTitle("Resume", for: UIControlState .normal)
            
        } else {
        // is resume is pressed
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
            
            startButton.setTitle("Pauze", for: UIControlState .normal)
        }
        
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        cancel()
        startButton.setTitle("Start", for: UIControlState .normal)
        cancelButton.isEnabled = false
        timeLabel.text = "00:00:00"
        timePicker.isEnabled = true
        
    }
    
    @IBAction func conformationSegue(_ sender: Any) {
        performSegue(withIdentifier: "conformationSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conformationSegue" {
            let conformationVC = segue.destination as! ConformationViewController
            conformationVC.activity = activity
        }
    }
    
    // MARK: - Navigation
    @IBAction func returnToMainView(segue: UIStoryboardSegue) {}

    

}

/*
// here all the timer ellements are handeld
*/
extension MainViewController {
    
    func start(seconds: Int) {
        
        self.countseconds = seconds
        
        if countRunning == false {
            // Timer is not running
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
            countRunning = true
            
        }
        
    }

    func resumePause() {
        
        if self.countPauzed {
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                              selector: (#selector(self.updateTimer)),
                                              userInfo: nil, repeats: true)
            
            self.countPauzed = false
            
        } else {
            
            self.timer.invalidate()
            self.countPauzed = true
        }
        
    }
    
    /// stops the timer and prepares of the next round
    func cancel() {
        
        self.countRunning = false
        self.timer.invalidate()
        self.timer = Timer()
    }
    
    
    /// this updates the timer every secon and checks if the timer is done.
    @objc func updateTimer() -> String {
        
        if countseconds < 1 {
            //Send alert to indicate "time's up!"
            self.timer.invalidate()
            self.performSegue(withIdentifier: "conformationSegue", sender: nil)
            return "Time is up"
        } else {
            
            self.countseconds -= 1
            self.timeLabel.text = self.timeString(time: TimeInterval(self.countseconds))
            return self.timeString(time: TimeInterval(self.countseconds))
            
        }
        
        
    }
    
    /// Creating a time stamp voor the timer to display
    private func timeString(time:TimeInterval) -> String {
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        
    }
    
}

// collection view properties
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sjaak.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! SelectActivitieIconCollectionViewCell
        
        cell.iconLabel.text = sjaak[indexPath.row]["label"] as? String
        cell.imageUrl = URL(string: sjaak[indexPath.row]["iconUrl"] as! String)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        // Deselect the previos selection if any
        if self.selectedItem != nil {
            let cell1 = collectionView.cellForItem(at: self.selectedItem!) as! SelectActivitieIconCollectionViewCell
            cell1.iconImage.backgroundColor = UIColor.clear
        }
        
        // select the touched cell
        let cell = collectionView.cellForItem(at: indexPath) as! SelectActivitieIconCollectionViewCell
        activity.iconLabel = cell.iconLabel.text!
        cell.iconImage.backgroundColor = UIColor.blue
        self.selectedItem = indexPath
        

        
    }
    


}
