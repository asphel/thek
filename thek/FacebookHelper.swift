//
//  FacebookHelper.swift
//  thek
//
//  Created by Leble, Loic on 13/09/2017.
//  Copyright © 2017 Leble, Loic. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftyJSON

struct Constant{
    
    struct Facebook {
        static let simpleUserPermission = ["public_profile","email","user_friends"]
        static let simpleUserFields = ["fields": "email, first_name, last_name, picture"]
        static let eventFields = ["fields": "name, start_time, end_time, place, description, cover, owner, ticket_uri, attending_count"]
    }
}


class FacebookHelper {

    static func queryToGraphPath(_ graphPath : String, with parameters : [String:String], completion : @escaping (JSON)->()) {
        
        FBSDKGraphRequest(graphPath: graphPath, parameters: parameters).start {(connection, result, error) -> Void in
            
            if let error = error {
                print("##### ##### FacebookHelper : queryToGraphPath - Request error\(error.localizedDescription)")
                return
            }
            
            let data = JSON(result as Any)
            completion(data)
        }
    }
}
