//
//  Event.swift
//  thek
//
//  Created by Leble, Loic on 11/09/2017.
//  Copyright © 2017 Leble, Loic. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class Event : NSObject {
    
    let eventId : String
    let name : String
    let coreDescription : String
    let startTime : String
    let endTime : String
    let coverImage : String
    
    init(_ item : FIRDataSnapshot) {
        
        let attributes = item.value as! [String:AnyObject]
        
        eventId = item.key
        name = attributes["name"] as! String
        coreDescription = attributes["description"] as! String
        startTime = attributes["startTime"] as! String
        endTime = attributes["endTime"] as! String
        coverImage = attributes["coverImage"] as! String
    }
    

    
    override var description: String {
        let string : String
        string = "##### EVENT\neventId : \(eventId)\n---name : \(name)\n---coreDescription : \(coreDescription)\n---startTime : \(startTime)\n---endTime : \(endTime)\n---coverImage : \(coverImage)"
        return string
    }
    
    
    
}

