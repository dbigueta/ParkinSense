//-----------------------------------------------------------------
//  File: WeeklyCalendar.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng, Hamlet Jiang Su
//
//  Description: Retrieves the current week, and the dates associated with each day
//
//  Changes:
//      - Fixed variable names not going according to standard
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import Foundation
import UIKit

var newCalendar = Calendar.current
var rightNow = Date()
var formatter = DateFormatter()
var dayFormatter = DateFormatter()
var dateFormatter = DateFormatter()
var lastTimeLoginDateStr = ""
var thisTimeLoginDateStr = ""

var weekInterval = dateRange
let startCurrentWeek = weekInterval.start
let endCurrentWeek = weekInterval.end - 3600*24
let formattedEndCurrentWeek = formatter.string(from: endCurrentWeek)
let formattedStartCurrentWeek = formatter.string(from: startCurrentWeek)


/**
     Obtains the current week date range from Sunday to Saturday
  
      - Parameter sender: None
  
      - Returns: weekInterval
         
 **/
var dateRange: DateInterval{
    formatter.dateFormat = "MM/dd"
    let weekInterval = newCalendar.dateInterval(of: .weekOfYear, for: rightNow)
    
    return weekInterval!
}


/**
     Obtains the end date of a given week
  
      - Parameter updateNow: Date
  
      - Returns: formattedEndCurrentWeek
         
 **/
func newEndCurrentWeek (updateNow: Date) -> String{
    formatter.dateFormat = "MM/dd"
    let weekInterval = newCalendar.dateInterval(of: .weekOfYear, for: updateNow)
    let endCurrentWeek = weekInterval!.end - 3600*24
    let formattedEndCurrentWeek = formatter.string(from: endCurrentWeek)
    
    return formattedEndCurrentWeek
}


/**
    Obtains the start date of a given week
 
     - Parameter updateNow: Date
 
     - Returns: formattedStartCurrentWeek
        
**/
func newStartCurrentWeek (updateNow: Date) -> String{
    formatter.dateFormat = "MM/dd"
    let weekInterval = newCalendar.dateInterval(of: .weekOfYear, for: updateNow)
    let startCurrentWeek = weekInterval!.start
    let formattedStartCurrentWeek = formatter.string(from: startCurrentWeek)
    
    return formattedStartCurrentWeek
}


/**
    Obtains the Sunday date of a given week
 
     - Parameter startCurrentWeek: Date
 
     - Returns: formattedSundayDate
        
**/
func sundayDate (startCurrentWeek: Date) -> String{
    dayFormatter.dateFormat = "dd"
    let weekInterval = newCalendar.dateInterval(of: .weekOfYear, for: startCurrentWeek)
    let sundayDate = weekInterval!.start
    let formattedSundayDate = dayFormatter.string(from: sundayDate)
    return formattedSundayDate
}


/**
    Obtains the Monday date of a given week
    
     - Parameter startCurrentWeek: Date
 
     - Returns: formattedMondayDate
        
**/
func mondayDate (startCurrentWeek: Date) -> String{
    dayFormatter.dateFormat = "dd"
    let weekInterval = newCalendar.dateInterval(of: .weekOfYear, for: startCurrentWeek)
    let mondayDate = weekInterval!.end - 3600*24*6
    let formattedMondayDate = dayFormatter.string(from: mondayDate)
    return formattedMondayDate
}


/**
    Obtains the Tuesday date of a given week
    
     - Parameter startCurrentWeek: Date
 
     - Returns: formattedTuesdayDate
        
**/


func tuesdayDate (startCurrentWeek: Date) -> String{
    dayFormatter.dateFormat = "dd"
    let weekInterval = newCalendar.dateInterval(of: .weekOfYear, for: startCurrentWeek)
    let tuesdayDate = weekInterval!.end - 3600*24*5
    let formattedTuesdayDate = dayFormatter.string(from: tuesdayDate)
    return formattedTuesdayDate
}


/**
    Obtains the Wednesday date of a given week
    
     - Parameter startCurrentWeek: Date
 
     - Returns: formattedWednesdayDate
        
**/
func wednesdayDate (startCurrentWeek: Date) -> String{
    dayFormatter.dateFormat = "dd"
    let weekInterval = newCalendar.dateInterval(of: .weekOfYear, for: startCurrentWeek)
    let wednesdayDate = weekInterval!.end - 3600*24*4
    let formattedWednesdayDate = dayFormatter.string(from: wednesdayDate)
    return formattedWednesdayDate
}


/**
    Obtains the Thursday date of a given week
    
     - Parameter startCurrentWeek: Date
 
     - Returns: formattedThursdayDate
        
**/
func thursdayDate (startCurrentWeek: Date) -> String{
    dayFormatter.dateFormat = "dd"
    let weekInterval = newCalendar.dateInterval(of: .weekOfYear, for: startCurrentWeek)
    let thursdayDate = weekInterval!.end - 3600*24*3
    let formattedThursdayDate = dayFormatter.string(from: thursdayDate)
    return formattedThursdayDate
}


/**
    Obtains the Friday date of a given week
    
     - Parameter startCurrentWeek: Date
 
     - Returns: formattedFridayDate
        
**/
func fridayDate (startCurrentWeek: Date) -> String{
    dayFormatter.dateFormat = "dd"
    let weekInterval = newCalendar.dateInterval(of: .weekOfYear, for: startCurrentWeek)
    let fridayDate = weekInterval!.end - 3600*24*2
    let formattedFridayDate = dayFormatter.string(from: fridayDate)
    return formattedFridayDate
}


/**
    Obtains the Saturday date of a given week
    
     - Parameter startCurrentWeek: Date
 
     - Returns: formattedSaturdayDate
        
**/
func saturdayDate (startCurrentWeek: Date) -> String{
    dayFormatter.dateFormat = "dd"
    let weekInterval = newCalendar.dateInterval(of: .weekOfYear, for: startCurrentWeek)
    let saturdayDate = weekInterval!.end - 3600*24
    let formattedSaturdayDate = dayFormatter.string(from: saturdayDate)
    return formattedSaturdayDate
}
