//
//  User.swift
//  thek
//
//  Created by Leble, Loic on 11/09/2017.
//  Copyright © 2017 Leble, Loic. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase


struct Friend {
    let facebookId : Int
    let name : String
}



class User : NSObject{
    
    var firebaseId : String?
    let facebookId : Int
    let email : String
    let firstName : String
    let lastName : String
    let updateTime : String
//    let profilePicture = String()
    
    static let userPath = FIRDatabase.database().reference().child("users")
    
    override var description: String {
        var string = String()
        string = "##### USER\nfacebookId : \(facebookId)\n---email : \(email)\n---firstName : \(firstName)\n---lastName : \(lastName)"
        return string
    }
    
    init(_ result:JSON) {
        
        if let currentUser = FIRAuth.auth()?.currentUser {
            self.firebaseId = currentUser.uid
        }

        self.facebookId = result["id"].intValue
        self.email = result["email"].stringValue
        self.firstName = result["first_name"].stringValue
        self.lastName = result["last_name"].stringValue
        self.updateTime = Helper.stringFromCurrentDate()
        
        super.init()
        
        createUserIfDoesntExist()
        
        // TODO: Handle the picture profile
        
    }
    
    func createUserIfDoesntExist() {
        
        let information : [String : Any] = ["facebookId" : self.facebookId,
                           "email" : self.email,
                           "firstName" : self.firstName,
                           "lastName" : self.lastName,
                           "updateTime" : self.updateTime,
                           "lastLogonTime" : ""
                           ]
        
        User.userPath.observeSingleEvent(of: .value, with: { (snapshot) in
            if let firebaseId = self.firebaseId {
                if !snapshot.hasChild(self.firebaseId!) {
                    print("##### ##### User : New user, creating the node : \(String(describing: self.firebaseId))")
                    User.userPath.child(firebaseId).setValue(information)
                }
                else {
                    print("##### ##### User : Registered user, updating lastLogonTime : \(String(describing: Helper.stringFromCurrentDate()))")
                    User.userPath.child(firebaseId).updateChildValues(["lastLogonTime" : Helper.stringFromCurrentDate() ])
                }
            }
        })
    }
    
    
    static func getUserIdFromFacebookId(_ facebookId : Int, completion : @escaping (String) -> ()) {
        
        User.userPath.queryOrdered(byChild: "facebookId").queryEqual(toValue: facebookId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChildren() {
                let json = JSON(snapshot.value as Any)
                if let userId = json.first?.0 {
                    if let result = String(userId)
                    {
                        completion(result)
                    }
                }
            } else {
                print("##### ##### User : getUserIdFromFacebookId - No corresponding user found")
            }
        })
    }
    
//    
//    func ifUserExists(completion : ()->()) {
//    
//            var result = false
//    
//            User.userPath.observeSingleEvent(of: .value, with: { (snapshot) in
//                if snapshot.hasChild(self.firebaseId!) {
//                
//                }
//    
//            })
//    
//    
//    
//            print("######## userExists :  \(result)")
//            return result
//        }
//    
}
