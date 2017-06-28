//
//  Fire.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//


/*
 This class house all Firebase related functions
 - writing to the database
 - writing to storage
 - removing data from database
 - removing files from storage
 
 It alsows stores:
 - the user id
 - a refference (dataRef) to the root of the firebase data structure
 - a refference (storeRef) to the root of the reibase storage structure
*/


import Foundation
import Firebase

class Fire {
    
    static let share = Fire()
    
    // keeping track of the current signed in user
    var userId = String()

    // creating frequently used reffrences (to the root database/storage)
    let dataRef = Database.database().reference()
    let storRef = Storage.storage().reference()

    
    /// saves a icon in storages and calls writeIconInfoDatabase
    func storeIcon(icon: UIImage, label: String) {
        
        // check is a user id is pressent if not get is
        if self.userId == "" {
            self.userId = (Auth.auth().currentUser?.uid)!
        }
        
        // reffrence where to store icon
        let storeRef = storRef.child("\(self.userId)/\(label).png")
        
        // compress icon
        let iconData = UIImageJPEGRepresentation(icon, 0.1)
        
        // store icon
        storeRef.putData(iconData!, metadata: nil) {
            (metadata, error) in
            
            // check for  error
            if error != nil {
                print(error!.localizedDescription)
            }
            
            // saving icon succes (no error)
            
            // on the main thread
            DispatchQueue.main.async {
                
                // collect location information for later use
                let iconInfo = ["iconUrl": metadata?.downloadURL()?.absoluteString ,
                                "label": label] as! [String: String]
                
                // store the icon information in the database
                self.writeIconInfoDatabase(data: iconInfo)
                
            }
            
        }
        
    }
    
    /// speciale function to write icon information to the database
    private func writeIconInfoDatabase(data: [String : String]) {
        
        // create a reffrence where to save the information
        let dataref = dataRef.child("pref").child(self.userId).childByAutoId()
        
        // store the information
        dataref.updateChildValues(data) {
            (error, reffrence) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            
            // succes (no error)
            
        }
    }
    
    /// removes an icon from the storages and database
    func deleteIconStorage(name: String) {
        
        let storeReff = Storage.storage().reference().child(self.userId).child("\(name).png")
        
        storeReff.delete {
            (error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            
            // succes (no error)
            
        }
        
        let dataRef = self.dataRef.child("pref/\(Fire.share.userId)")
        
        dataRef.queryOrderedByKey().observe(DataEventType.value, with: {
            (snapshot) in
            
            // convert value check guard again error
            guard let value = snapshot.value as? NSDictionary else {
                return
            }
            
            // go through every key
            for key in value.allKeys {
                
                // convert the value behind the key in a dictionary
                let dict = value[key] as! NSDictionary
                
                // scan for where label name is equal to tobe delete iconname
                if dict["label"] as! String == name {
                    
                    let dataRef = self.dataRef
                                      .child("pref/\(Fire.share.userId)")
                                      .child(key as! String)
                    
                    dataRef.removeValue()
                    
                    // if value is found searches done
                    return
                    
                }
                
            }
          
            
        })
        
    }
    
}
