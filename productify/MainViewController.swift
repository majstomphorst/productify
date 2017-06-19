//
//  MainViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var timeLabel: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    // timer requirements
    var timer = Timer()
    var countseconds = Int()
    var countRunning = false
    var countPauzed = false
    
    let sjaak = ["01","02"]
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Check if user is signin or not
        if let userId = Auth.auth().currentUser?.uid {
            
            // save userId for later use
            Fire.shared.userId = userId
            
        } else {
            
            // user is not signin send them to the sigin page
            performSegue(withIdentifier: "signinSegue", sender: nil)
        }
        
    }
    
    
    // MARK: - Actions
    
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
    
    // MARK: - Navigation
    @IBAction func returnToMainView(segue: UIStoryboardSegue) {}


}


// here all the timer ellements are handeld
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
    
    func cancel() {
        
        self.countRunning = false
        self.timer.invalidate()
        self.timer = Timer()
    }
    
    
    @objc func updateTimer() -> String {
        
        if countseconds < 1 {
            //Send alert to indicate "time's up!"
            self.timer.invalidate()
            return "Time is up"
        } else {
            
            self.countseconds -= 1
            print(self.timeString(time: TimeInterval(self.countseconds)))
            
            self.timeLabel.text = self.timeString(time: TimeInterval(self.countseconds))
            
            return self.timeString(time: TimeInterval(self.countseconds))
        }
        
        
    }
    
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
        
        cell.IconLabel.text = sjaak[indexPath.row]
    
        return cell
    }

}
