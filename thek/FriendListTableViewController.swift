//
//  FriendListViewController.swift
//  thek
//
//  Created by Leble, Loic on 11/09/2017.
//  Copyright © 2017 Leble, Loic. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import SwiftyJSON



class FriendListViewController: UITableViewController {
    
    var friendList = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameters = ["fields": "email, name"]
        
        FBSDKGraphRequest(graphPath: "me/friends", parameters: parameters).start {(connection, result, error) -> Void in
            
            if error != nil {
                NSLog(error.debugDescription)
                return
            }
            
            let jsonResult = JSON(result as Any)
            let jsonFriends = jsonResult["data"]
            
            for item in jsonFriends {
                
                let friend = Friend(facebookId: item.1["id"].stringValue, name: item.1["name"].stringValue)
                self.friendList.append(friend)
            }
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendCell
        cell.backgroundColor = .green
        cell.friend = friendList[indexPath.row]
        return cell
    }

    


}
