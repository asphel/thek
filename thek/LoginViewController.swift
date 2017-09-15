//
//  ViewController.swift
//  thek
//
//  Created by Leble, Loic on 10/09/2017.
//  Copyright © 2017 Leble, Loic. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import SwiftyJSON



class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func login(_ sender: UIButton) {
        loginWithFacebook(sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.roundedButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let currentUser = FIRAuth.auth()?.currentUser
        
        if currentUser != nil  {
            performSegue(withIdentifier: "loginWithFacebook", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loginWithFacebook(sender: UIButton) {
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email","user_friends"], from: self) {
            (result, error) in
            
            if let error = error {
                print("##### Failed to login : \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("##### Failed to get accessToken")
                return
            }
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            FIRAuth.auth()?.signIn(with: credential) {
                (user, error) in
                
                if let error = error {
                    print("##### Failed to signIn : \(error.localizedDescription)")
                    return
                }
                
                let parameters = ["fields": "email, first_name, last_name, picture"]
                
                FBSDKGraphRequest(graphPath: "me", parameters: parameters).start {(connection, result, error) -> Void in
                    
                    if error != nil {
                        NSLog(error.debugDescription)
                        return
                    }
                    
                    let jsonResult = JSON(result as Any)
                    let user = User(jsonResult)
                }
                
                self.performSegue(withIdentifier: "loginWithFacebook", sender: sender)
            }
        }
    }
}

