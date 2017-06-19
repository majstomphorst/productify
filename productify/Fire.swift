//
//  Fire.swift
//  productify
//
//  Created by Maxim Stomphorst on 16/06/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import Foundation
import Firebase

class Fire {
    
    static let shared = Fire()
    
    var userId = String()

    /// save's a icon in the Firebase storage and saves the info in the database
    func storeIcon(icon: UIImage, label: String) {
        
        if self.userId == "" {
            self.userId = (Auth.auth().currentUser?.uid)!
        }
        
        
        let storeRef = Storage.storage().reference().child("\(self.userId)/\(label).png")
        let iconData = UIImagePNGRepresentation(icon)
        
        storeRef.putData(iconData!, metadata: nil) { (metadata, error) in
            
            // check for  error
            if error != nil {
                print(error!.localizedDescription)
            }
            
            // saving icon is succes
            DispatchQueue.main.async {
                
                let iconInfo = ["iconUrl": metadata?.downloadURL()?.absoluteString ,
                                "label": label] as! [String: String]
                
                self.writeIconInfoDatabase(data: iconInfo as NSDictionary)
                
            }
            
        }
        
    }
    
    /// speciale function to write icon info to the database
    private func writeIconInfoDatabase(data: NSDictionary) {
        
        let ref = Database.database().reference().child("pref").child(self.userId).childByAutoId()
        
        ref.updateChildValues(data as! [AnyHashable : Any]) { (error, DatabaseReference) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            
            // succes
            
        }
    }
    
    /// remove's an icon from the storages and out of the database
    func deleteIconStorage(name: String) {
        
        let reff = Storage.storage().reference().child(self.userId).child("\(name).png")
        
        reff.delete { (error) in
            
        }
        
        Database.database().reference().child("pref/\(Fire.shared.userId)").queryOrderedByKey().observe(DataEventType.value, with: { (snapshot) in
            
            guard let value = snapshot.value as? NSDictionary else {
                return
            }
            
                
            for key in value.allKeys {
                
                let dict = value[key] as! NSDictionary
                
                if dict["label"] as! String == name {
                    
                    let ref = Database.database().reference().child("pref/\(Fire.shared.userId)").child(key as! String)
                    
                    ref.removeValue()
                    
                    
                }
                
            }
          
            
        })
        
    }
    
    
}
