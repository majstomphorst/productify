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

    
    
    // timer requirements
    var timer = Timer()
    var countseconds = Int()
    var countRunning = false
    var countPauzed = false
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        // Check if user is signin or not
        if let userId = Auth.auth().currentUser?.uid {
            
            print(userId)
            
            Fire.shared.userId = userId
            // user is signin
        } else {
            // user is not signin
            print("segue")
            performSegue(withIdentifier: "signinSegue", sender: nil)
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func button(_ sender: Any) {
        
        print("hello?")
        
        do {
            try Auth.auth().signOut()
            
            self.performSegue(withIdentifier: "signinSegue", sender: nil)
            
            // if error this send a alert to the user with the reason why
        } catch {
            
            // alertUser(title: "logout went wrong", message: error.localizedDescription)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func startButton(_ sender: Any) {
        
        if startButton.currentTitle == "Start" {
            
            startButton.setTitle("Pauze", for: UIControlState .normal)
            cancelButton.isEnabled = true
            start(seconds: 30)
            
            
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
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
            
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
