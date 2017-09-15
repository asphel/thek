//
//  Helper.swift
//  thek
//
//  Created by Leble, Loic on 12/09/2017.
//  Copyright © 2017 Leble, Loic. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    static func stringFromCurrentDate() -> String {
        let currentDate = Date()
        return self.stringFromDate(currentDate)
    }
    
    static func stringFromDate(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let UTCDate = dateFormatter.string(from: date)
        return UTCDate
    }
    
    static func generateRandomCode() -> String {
        let randomNum:UInt32 = arc4random_uniform(99999999)+10000000
        return String(randomNum)
    }
}

extension UIButton{
    func roundedButton(){
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.allCorners],
                                     cornerRadii:CGSize(width: 15.0, height: 15.0))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
}
