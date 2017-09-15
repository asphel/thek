//
//  key.swift
//  thek
//
//  Created by Leble, Loic on 11/09/2017.
//  Copyright © 2017 Leble, Loic. All rights reserved.
//

import Foundation
import Firebase

enum KeyStatus {
    case unused
    case used
    case expired
}

class Key : NSObject {
    
    let keyId : String
    let eventId : Int
    let creationTime : String
    let expirationTime : String
    let additionalGuest : Int
    let mainPrice : Double
    let guestPrice : Double
    let status : String
    
    

    override var description: String {
        let string : String
        string = "##### KEY\nkeyId : \(keyId)\n---eventId : \(eventId)\n---creationTime : \(creationTime)\n---expirationTime : \(expirationTime)\n---additionalGuest : \(additionalGuest)\n---mainPrice : \(mainPrice)\n---guestPrice: \(guestPrice)\n---status: \(status)"
        return string
    }
    
    init(_ item : FIRDataSnapshot) {
        
        let attributes = item.value as! [String:AnyObject]
        
        keyId = item.key
        eventId = attributes["eventId"] as! Int
        creationTime = attributes["creationTime"] as! String
        expirationTime = attributes["expirationTime"] as! String
        additionalGuest = attributes["additionalGuest"] as! Int
        mainPrice = attributes["mainPrice"] as! Double
        guestPrice = attributes["guestPrice"] as! Double
        status = attributes["status"] as! String
    }
    
    func moveKeyToAnotherUser(_ anotherUserId:String)
    {
        if let userId = FIRAuth.auth()?.currentUser?.uid {
            User.userPath.child(userId).child("keys").child(self.keyId).observe(.value, with: { (snapshot) in
                print("#### TEST \(snapshot)")
                if let data = snapshot.value as? [String : AnyObject] {
                    User.userPath.child(anotherUserId).child("keys").child(self.keyId).setValue(data)
                    User.userPath.child(userId).child("keys").child(self.keyId).removeValue()
                    print("##### ##### Key : moveKeyToAnotherUser success")
                }
            })
        }
    }
    
    static func addRandomKeyToUser(_ userId:String) {

        
        let _keyId = Helper.generateRandomCode()
        let _eventId = 258587941306607
        let _creationTime = Helper.stringFromCurrentDate()
        let _expirationTime = Helper.stringFromDate(Calendar.current.date(byAdding: .day, value: 10, to: Date())!)
        let _additionalGuest = 2
        let _mainPrice = 0.0
        let _guestPrice = 5.0
        let _status = "available"
        let _keyDescription = ""
        
        let attributes : [String : Any] = [ "eventId" : _eventId,
                                            "_keyDescription" : _keyDescription,
                                            "creationTime" : _creationTime,
                                            "expirationTime" : _expirationTime,
                                            "additionalGuest" : _additionalGuest,
                                            "mainPrice" : _mainPrice,
                                            "guestPrice" : _guestPrice,
                                            "status" : _status
        ]
        
        
        User.userPath.child(userId).child("keys").child(_keyId).setValue(attributes)
        
    }
    
    
    
    
}
