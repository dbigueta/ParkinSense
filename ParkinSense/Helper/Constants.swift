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

/* Home UI Constants*/
var screenHeight = UIScreen.main.bounds.height
var screenWidth = UIScreen.main.bounds.width
let headerFontSize:CGFloat = 20

var weekButtonHeight: CGFloat = 30

var homeDayButtonBorderWidth:CGFloat = 2
var homeDayButtonWidth = screenWidth/4 - 5

var homeGameButtonBorderWidth:CGFloat = 2
var homeGameButtonWidth = screenWidth/2 - 20

var headerHeight:CGFloat = 50
var gameLabelHeight: CGFloat = 30

var progressViewHeight: CGFloat = 50
var dataScrollViewHeight: CGFloat = 250
var calendarViewHeight: CGFloat = 340
var gameViewHeight: CGFloat = 250

var offsetTopWeekButtons = (screenWidth - (4*homeDayButtonWidth))/5
var offsetBottomWeekButtons = (screenWidth - (3*homeDayButtonWidth) - 2*offsetTopWeekButtons)/2
var offsetGameButtons = (screenWidth - (2*homeGameButtonWidth))/3



/* TILT Game */
var tiltLabelHeight:CGFloat = 25
var instructionsLabelHeight:CGFloat = 25

var soundLabelHeight:CGFloat = 25
var soundLabelWidth:CGFloat = screenWidth/2
var soundToggleWidth:CGFloat = 2*screenWidth/5

var startButtonHeight:CGFloat = 50
var startButtonWidth:CGFloat = 2*screenWidth/3
var tiltStartButtonOffset:CGFloat = (1/3*screenWidth)/2

var quitButtonHeight:CGFloat = 50
var quitButtonWidth:CGFloat = 2*screenWidth/3
var tiltQuitButtonOffset:CGFloat = (1/3*screenWidth)/2

var timeStaticLabelHeight:CGFloat = 25
var scoreStaticLabelHeight:CGFloat = 25

var countdownLabelHeight:CGFloat = screenWidth
var countdownLabelWidth:CGFloat = screenHeight
var countdownFont = UIFont.systemFont(ofSize: 90, weight: .light)

var finalScoreStaticLabelHeight:CGFloat = 25
var finalScoreLabelHeight:CGFloat = 25
var replayButtonHeight:CGFloat = 25
var finalQuitButtonHeight:CGFloat = 25
var replayButtonWidth:CGFloat = 25
var finalQuitButtonWidth:CGFloat = 25

/* Main UI & Login Colours */
let textColour = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
let buttonTextColour = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
let buttonColour = UIColor(red:0.75, green:0.85, blue:0.84, alpha:1.0)
let font = UIFont.systemFont(ofSize: 20, weight: .light)
let selectedDayBackgroundColour = UIColor(red:0.69, green:0.75, blue:0.84, alpha:1.0)

/*Tilt Colours*/
let tiltBackgroundColour = UIColor(red:1.00, green:0.97, blue:0.83, alpha:1.0)
let tiltTextColour = UIColor(red:0.18, green:0.26, blue:0.28, alpha:1.0)
let tiltButtonColour = UIColor(red:1.00, green:0.72, blue:0.52, alpha:1.0)
let tiltTitleFont = UIFont.systemFont(ofSize: 35, weight: .regular)
