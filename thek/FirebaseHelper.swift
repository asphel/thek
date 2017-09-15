//
//  FirebaseHelper.swift
//  thek
//
//  Created by Leble, Loic on 13/09/2017.
//  Copyright © 2017 Leble, Loic. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import Firebase
import SwiftyJSON

class FirebaseHelper {
    
    static func ifUserLoggedIn(completion: ()->()) {
        let currentUser = FIRAuth.auth()?.currentUser
        
        if currentUser != nil  {
            completion()
        }
    }

}
