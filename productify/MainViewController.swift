//
//  MainViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase
import NotificationCenter
import UserNotifications


class MainViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var timeLabel: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var activitySelector: UICollectionView!
    @IBOutlet weak var todoField: UITextView!
    
    //
    var selectedItem: IndexPath?
    
    // timer requirements
    var timer = Timer()
    // timer is running? update every second (-1)
    var countseconds = Int()
    
    //
    var usersIcons = [NSDictionary]()
    
    var activity = ActivityInfo()
    
    // get to the notification function in AppDelegate
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidAppear(_ animated: Bool) {
    
        // Check if user is signin or not
        if let userId = Auth.auth().currentUser?.uid {
            
            // save userId for later use
            Fire.shared.userId = userId
            
            // this load's all the user's activity icons and labels
            Database.database().reference().child("pref/\(Fire.shared.userId)")
                .queryOrderedByKey().observe(DataEventType.value, with:
                    { (snapshot) in
                
                self.usersIcons = [NSDictionary]()
                    
                guard let value = snapshot.value as? NSDictionary else {
                    return
                }
                
                    
                for key in value.allKeys {
                    self.usersIcons.append(value[key] as! NSDictionary)
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
    
    /// signs a user out and send them to the sigin page
    @IBAction func signoutPress(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signinSegue", sender: nil)
            
        } catch {
            
            // if error this send a alert to the user with the reason why
            alertUser(title: "logout went wrong", message: error.localizedDescription)
        }
        
    }
    
    /*
    // Turn a observer on: on 
    // - UIApplicationDidBecomeActive
    // - UIApplicationWillResignActive
    */
    func observersOn() {
        
        let notification = NotificationCenter.default
        
        // observs this view if actie it calls func didBecomeActive
        notification.addObserver(self, selector: #selector(didBecomeActive),
                                 name: .UIApplicationDidBecomeActive,
                                 object: nil)
        
        // observs this view if Resign active it calls func willResignActive
        notification.addObserver(self, selector: #selector(willResignActive),
                                 name: .UIApplicationWillResignActive,
                                 object: nil)
        
    }
    
    /*
    // Turn a observer off: on
    // - UIApplicationDidBecomeActive
    // - UIApplicationWillResignActive
    */
    func observersOff() {
        
        let notification = NotificationCenter.default
        
        notification.removeObserver(self, name: .UIApplicationDidBecomeActive,
                                    object: nil)
        
        notification.removeObserver(self, name: .UIApplicationWillResignActive,
                                    object: nil)
    }
    
    
    /*
    // This ubtton has 3 state's
    // - Start
    // - Pauze
    // - Resume
    //
    // The goal is to manage the timer and notifications.
    // this is done by observers
    */
    @IBAction func startButton(_ sender: Any) {
        
        if startButton.currentTitle == "Start" {
            
            // lissing for resign active and active again
            observersOn()
            
            // get's the countdown for scheduling a notificaion
            self.countseconds = Int(timePicker.countDownDuration)
            
            
            self.appDelegate?.setNotification(countDown: Double(self.countseconds),
                                                   title: "You ar done",
                                                   body: "Body")
            
            // collect information for database
            activity.time = Int(timePicker.countDownDuration)

            
            // running the timer
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                         selector: (#selector(self.updateTimer)),
                                         userInfo: nil, repeats: true)
            
            // update UI
            startButton.setTitle("Pauze", for: UIControlState .normal)
            cancelButton.isEnabled = true
            timePicker.isEnabled = false
            
            
            
        } else if startButton.currentTitle == "Pauze" {
            
            // kill observers
            observersOff()
            
            // kill all notifications
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            
            // pauze's the timer
            self.timer.invalidate()
            
            // update UI
            startButton.setTitle("Resume", for: UIControlState .normal)
            
        } else {
            // is resume is pressed
            
            observersOn()
            
            // start up the timer again with the remaing time (stored in countSeconds
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                              selector: (#selector(self.updateTimer)),
                                              userInfo: nil, repeats: true)
            
            // schedul new notification
            self.appDelegate?.setNotification(countDown: Double(self.countseconds),
                                                   title: "Title",
                                                   body: "Body")
            
            // update UI
            startButton.setTitle("Pauze", for: UIControlState .normal)
        }
        
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        // kill all observers
        observersOff()

        // stops the timer
        self.timer.invalidate()
        self.timer = Timer()
        
        // update UI
        startButton.setTitle("Start", for: UIControlState .normal)
        cancelButton.isEnabled = false
        timeLabel.text = "00:00:00"
        timePicker.isEnabled = true
        
    }
    
    
    @IBAction func conformationSegue(_ sender: Any) {
        performSegue(withIdentifier: "conformationSegue", sender: nil)
    }
    
    // MARK: - Functions
    
    /// if a timer is running this wil get called when app becomes active
    @objc func didBecomeActive() {
        
        // retrieving stored information
        let timeStampResign = UserDefaults.standard.double(forKey: "resignTime")
        let countseconds = UserDefaults.standard.double(forKey: "countseconds")
        let timeStampActive = Date().timeIntervalSince1970
        
        // calculate new time
        let newTime = countseconds - (timeStampActive - timeStampResign)
        
        // if timer is greater than 0 update it to the new time
        if newTime >= 0  {
            
            self.countseconds = Int(newTime)
            print("time not up")
            
        } else {
            // if time is up set time to 0
            
            self.countseconds = 0
            print("time up")
            
        }
        
    }
    
    
    /// if a timer is running this wil get called when app resigns active
    @objc func willResignActive() {
        
        // getting the current time
        let timeStamp = Date().timeIntervalSince1970
        
        // saving current time and timer time for when the app returns
        UserDefaults.standard.set(timeStamp, forKey: "resignTime")
        UserDefaults.standard.set(countseconds, forKey: "countseconds")
        
    }
    
    /// this updates the timer every second and checks if the timer is done
    @objc func updateTimer() {
        
        // if time is not up
        if countseconds >= 1 {
            
            // update timer minus 1
            self.countseconds -= 1
            // update the time label
            self.timeLabel.text = timeString(time: TimeInterval(self.countseconds))
            
        } else {
            // if time is up
            
            // simulates a cancel press so that the timer is reset
            self.cancelButton(self)
            
            // cleaning UI
            self.todoField.text = ""
            
            // send user to the conformation screen
            self.performSegue(withIdentifier: "conformationSegue", sender: nil)
            
        }
        
        
    }
    
    // MARK: - Navigation
    
    // Creates a way to unwind a segue
    @IBAction func returnToMainView(segue: UIStoryboardSegue) {}
    
    // sends the activity information to the conformation screen to be stored
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conformationSegue" {
            let conformationVC = segue.destination as! ConformationViewController
            conformationVC.activity = activity
        }
    }

}


// collection view properties
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! SelectActivitieIconCollectionViewCell
        
        cell.iconLabel.text = usersIcons[indexPath.row]["label"] as? String
        cell.imageUrl = URL(string: usersIcons[indexPath.row]["iconUrl"] as! String)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        // Deselect the previos selection if any
        if self.selectedItem != nil {
            let cell1 = collectionView.cellForItem(at: self.selectedItem!) as! SelectActivitieIconCollectionViewCell
            cell1.iconImage?.backgroundColor = UIColor.clear
        }
        
        // select the touched cell
        let cell = collectionView.cellForItem(at: indexPath) as! SelectActivitieIconCollectionViewCell
        activity.iconLabel = cell.iconLabel.text!
        cell.iconImage?.backgroundColor = UIColor.blue
        self.selectedItem = indexPath
        

        
    }
    


}
