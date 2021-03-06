//
//  MainViewController.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 This is the main view this house all the core functionaltie.
 
 Functions
 - setting a timer
 - selecting a activitie icon and linked label
   This is user specifiek?
 - Tel the activie what you are going to do in selected time
 -- it sets a notification for if you leave the app, so it call you back
 -- if the timer is done it send you to the conformation screen where you can
    compleet your activitie.
*/

import UIKit
import Firebase
import NotificationCenter
import UserNotifications


class MainViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var timeLabel: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var activitySelector: UICollectionView!
    @IBOutlet weak var todoField: UITextView!
    
    // save what itme is selected (for the UI) to that i can be de hiligted
    var selectedItem: IndexPath?
    
    // timer requirements
    var timer = Timer()
    // timer is running? update every second (-1)
    var countseconds = Int()
    
    // a way to keep track of what icons the user has
    var usersIcons = [NSDictionary]()
    
    var activity = ActivityInfo()
    
    // get to the notification function in AppDelegate
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidAppear(_ animated: Bool) {
    
        // check if user is signin or not
        if let userId = Auth.auth().currentUser?.uid {
            
            // save userId for later use
            Fire.share.userId = userId
            
            // this load's all the user's activity icons and labels
            Database.database().reference().child("pref/\(Fire.share.userId)")
                .queryOrderedByKey().observe(DataEventType.value, with:
                    { (snapshot) in
                
                // empty userIcons (no duplicates)
                self.usersIcons = [NSDictionary]()
                
                guard let value = snapshot.value as? NSDictionary else {
                    return
                }
                
                // scan every key (icon)
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
    
    /// debug segu a qucik way to trigger a segu else waiting for timer
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
    
    /// button has three states 1. Start 2. Pauze 3. Resume
    /// managing timer and notification with assistance from observers
    @IBAction func startButton(_ sender: Any) {
        
        if startButton.currentTitle == "Start" {
            
            // collect information for database
            activity.time = Int(timePicker.countDownDuration)
            
            countseconds = Int(timePicker.countDownDuration)
            
            // lissing for resign active and active
            observersOn()
            scheduleNotification(timeinterval: Int(timePicker.countDownDuration))
            

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
            
            // timer is running again
            observersOn()
            
            // start up the timer with the remaing time (stored in countSeconds)
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                    selector: (#selector (self.updateTimer)),
                                    userInfo: nil, repeats: true)
            
            scheduleNotification(timeinterval: self.countseconds)
            
            // update UI
            startButton.setTitle("Pauze", for: UIControlState .normal)
        }
        
        
    }
    
    /// cancel the timer and sets it up for the next run
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
    
    /// performs a segue way too the confirmation view
    @IBAction func conformationSegue(_ sender: Any) {
        performSegue(withIdentifier: "conformationSegue", sender: nil)
    }
    
    // MARK: - Functions
    
    /// Sets a observer on:
    /// - UIApplicationDidBecomeActive and UIApplicationWillResignActive
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
    
    /// Turn a observer off: on
    /// - UIApplicationDidBecomeActive and UIApplicationWillResignActive
    func observersOff() {
        
        let notification = NotificationCenter.default
        
        notification.removeObserver(self, name: .UIApplicationDidBecomeActive,
                                    object: nil)
        
        notification.removeObserver(self, name: .UIApplicationWillResignActive,
                                    object: nil)
    }
    
    /// if a timer is running this wil get called when app becomes active
    @objc func didBecomeActive() {
        
        // retrieving stored information
        let saved = UserDefaults.standard
        
        let timeResign = saved.double(forKey: "resignTime")
        let time = saved.double(forKey: "time")
        let timeActive = Date().timeIntervalSince1970
        
        // calculate new time
        let newTime = time - (timeActive - timeResign)
        
        // if timer is greater than 0 update it to the new time
        if newTime >= 0  {
            
            self.countseconds = Int(newTime)
            
        } else {
            // if time is up set time to 0
            self.countseconds = 0
            
        }
        
    }
    
    /// if a timer is running this wil get called when app resigns active
    @objc func willResignActive() {
        
        // getting the current time
        let time = Date().timeIntervalSince1970
        
        // saving current time and timer time for when the app returns
        UserDefaults.standard.set(time, forKey: "resignTime")
        UserDefaults.standard.set(countseconds, forKey: "time")
        
    }
    
    /// this updates the timer every second and checks if the timer is done
    @objc func updateTimer() {
        
        // if time is not up
        if countseconds < 1 {
            // simulates a cancel press so that the timer is reset
            self.cancelButton(self)
            
            // cleaning UI
            self.todoField.text = ""
            
            // send user to the conformation screen
            self.performSegue(withIdentifier: "conformationSegue", sender: nil)
            
        } else {
            // if time is not up
            
            // update timer minus 1
            self.countseconds -= 1
            // update the time label
            self.timeLabel.text = timeString(time: TimeInterval(self
                .countseconds))
            
        }
        
    }
    
    // MARK: - Navigation
    
    /// Creates a way to unwind a segue
    @IBAction func returnToMainView(segue: UIStoryboardSegue) {}
    
    /// sends the activity information to the conformation screen to be stored
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conformationSegue" {
            let conformationVC = segue.destination as! ConformationViewController
            conformationVC.activity = activity
        }
    }

}

/*
 collection view properties
*/
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// number of cells needed
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return usersIcons.count
    }
    
    /// provide cell content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
                            index: IndexPath) -> UICollectionViewCell {
        

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: index as IndexPath) as!SelectActivitieIconCollectionViewCell
        
        cell.iconLabel.text = usersIcons[index.row]["label"] as? String
        cell.imageUrl = URL(string: usersIcons[index.row]["iconUrl"] as! String)
    
        return cell
    }
    
    /// if a cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt index: IndexPath) {
        
        // Deselect the previos selection if any
        if self.selectedItem != nil {
            let cell1 = collectionView.cellForItem(at: self.selectedItem!)
                                       as! SelectActivitieIconCollectionViewCell
            
            cell1.iconLabel.backgroundColor = UIColor.clear
            cell1.iconImage?.backgroundColor = UIColor.clear
        }
        
        // select the touched cell
        let cell = collectionView.cellForItem(at: index)
                                       as! SelectActivitieIconCollectionViewCell
        
        
        activity.iconLabel = cell.iconLabel.text!
        cell.iconImage?.backgroundColor = UIColor.blue
        cell.iconLabel.backgroundColor = UIColor.blue
        self.selectedItem = index
    
        
    }
    

}
