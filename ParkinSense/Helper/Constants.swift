//-----------------------------------------------------------------
//  File: Constants.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng
//
//  Description: Stores global variables that need to be accessed between files
//
//  Changes:
//      - Added variables to use globally in all files
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import Foundation
import Charts

var medicationName = "None"

var medicationLabelAlpha = 0

var username = ""

var password = ""

var timePickerTime = ""

var userid = ""

var maxScoreToday = 0

var gamedata1 = 0

var gamedata2 = 0

var gamedata3 = 0

var gamedata4 = 0

var gamedata5 = 0

var gamedata6 = 0

var gamedata7 = 0

var values = [gamedata1, gamedata2, gamedata3, gamedata4, gamedata5, gamedata6, gamedata7]

/* UI Constants*/

var headerHeight:CGFloat = 20

var weekButtonHeight: CGFloat = 30

var gameLabelHeight: CGFloat = 30

var screenWidth = UIScreen.main.bounds.width

var homeDayButtonBorderWidth:CGFloat = 2

var homeDayButtonWidth = screenWidth/4 - 5

var homeGameButtonBorderWidth:CGFloat = 2

var homeGameButtonWidth = screenWidth/2 - 5

var calendarViewHeight: CGFloat = 350
var progressViewHeight: CGFloat = 350


/* TILT Game */
var tiltLabelHeight:CGFloat = 25
var instructionsLabelHeight:CGFloat = 25
var startButtonHeight:CGFloat = 25
var soundLabelHeight:CGFloat = 25
var quitButtonHeight:CGFloat = 25
var startButtonWidth:CGFloat = 2*screenWidth/3
var quitButtonWidth:CGFloat = 2*screenWidth/3

var timeStaticLabelHeight:CGFloat = 25
var scoreStaticLabelHeight:CGFloat = 25

var finalScoreStaticLabelHeight:CGFloat = 25
var finalScoreLabelHeight:CGFloat = 25
var replayButtonHeight:CGFloat = 25
var finalQuitButtonHeight:CGFloat = 25
var replayButtonWidth:CGFloat = 25
var finalQuitButtonWidth:CGFloat = 25

/* Other */
let textColour = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
let buttonTextColour = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
let buttonColour = UIColor(red:0.75, green:0.85, blue:0.84, alpha:1.0)
let font = UIFont.systemFont(ofSize: 20, weight: .light)

