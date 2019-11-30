//-----------------------------------------------------------------
//  File: TimeandExtension.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng, Hamlet Jiang Su
//
//  Description: Formats the time to be used later**
//
//  Changes:
//      - None
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import Foundation
import UIKit

extension Date {
    /**
     Obtains a formatted version of the time to be used in other functions
     
     - Parameter hour: Integer containing the hour
     - Parameter minute: Integer containin the minute
     
     - Returns: calculatedTime
     
     **/
    static func calculateTime(hour:Int, minute: Int) -> Date {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let calculatedTime = formatter.date(from: "\(hour):\(minute)")
        
        return calculatedTime!
    }
    
}
