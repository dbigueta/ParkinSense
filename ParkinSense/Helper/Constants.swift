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

/* Main UI & Login Colours */
let textColour = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
let buttonTextColour = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
let buttonColour = UIColor(red:0.75, green:0.85, blue:0.84, alpha:1.0)
let font = UIFont.systemFont(ofSize: 20, weight: .light)
let selectedDayBackgroundColour = UIColor(red:0.69, green:0.75, blue:0.84, alpha:1.0)


/* TILT Game */
var tiltLabelHeight:CGFloat = 50
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

var replayButtonHeight:CGFloat = 50
var replayButtonWidth:CGFloat = 2*screenWidth/3
var tiltReplayButtonButtonOffset:CGFloat = (1/3*screenWidth)/2

var finalQuitButtonHeight:CGFloat = 50
var finalQuitButtonWidth:CGFloat = 2*screenWidth/3
var tiltFinalQuitButtonOffset:CGFloat = (1/3*screenWidth)/2

var timeStaticLabelHeight:CGFloat = 25
var timeStaticLabelWidth:CGFloat = screenWidth/5

var scoreStaticLabelHeight:CGFloat = 25
var scoreStaticLabelWidth:CGFloat = screenWidth/5

var timeLabelHeight:CGFloat = 25
var timeLabelWidth:CGFloat = screenWidth/5

var scoreLabelHeight:CGFloat = 25
var scoreLabelWidth:CGFloat = screenWidth/5

var countdownLabelHeight:CGFloat = screenWidth
var countdownLabelWidth:CGFloat = screenHeight
var countdownFont = UIFont.systemFont(ofSize: 90, weight: .light)

var finalScoreStaticLabelHeight:CGFloat = 50
var finalScoreLabelHeight:CGFloat = 50

let tiltStaticFont = UIFont.systemFont(ofSize: 25, weight: .bold)
let tiltFont = UIFont.systemFont(ofSize: 22, weight: .regular)

var tiltFinalScore = 0


/*Tilt Colours*/
let tiltBackgroundColour = UIColor(red:0.92, green:0.91, blue:0.88, alpha:1.0)
let tiltTextColour = UIColor(red:0.27, green:0.45, blue:0.62, alpha:1.0)
let tiltButtonColour = UIColor(red:0.78, green:0.83, blue:0.88, alpha:1.0)
let tiltTitleFont = UIFont.systemFont(ofSize: 50, weight: .regular)
let tiltFinalScoreFont = UIFont.systemFont(ofSize: 40, weight: .regular)

let tiltGameBackgroundColour = UIColor(red:0.92, green:0.91, blue:0.88, alpha:1.0)
let tiltBallColour = UIColor(red:0.27, green:0.45, blue:0.62, alpha:1.0)
let tiltHoleColour = UIColor(red:0.74, green:0.72, blue:0.68, alpha:1.0)

let countdownBackgroundColour = UIColor(red:0.27, green:0.45, blue:0.62, alpha:1.0)
let countdownTextColour = UIColor(red:0.74, green:0.72, blue:0.68, alpha:1.0)


/* Bubble Game */
var bubbleLabelHeight:CGFloat = 50
var bubbleStartButtonOffset:CGFloat = (1/3*screenWidth)/2

var bubbleQuitButtonOffset:CGFloat = (1/3*screenWidth)/2

var bubbleReplayButtonButtonOffset:CGFloat = (1/3*screenWidth)/2

var bubbleFinalQuitButtonOffset:CGFloat = (1/3*screenWidth)/2

let bubbleStaticFont = UIFont.systemFont(ofSize: 25, weight: .bold)
let bubbleFont = UIFont.systemFont(ofSize: 22, weight: .regular)
let bubbleTitleFont = UIFont.systemFont(ofSize: 50, weight: .regular)
let bubbleFinalScoreFont = UIFont.systemFont(ofSize: 40, weight: .regular)

var bubbleFinalScore = 0


/* Bubble Colours */
let bubbleBackgroundColour = UIColor(red:0.92, green:0.91, blue:0.88, alpha:1.0)
let bubbleTextColour = UIColor(red:0.27, green:0.45, blue:0.62, alpha:1.0)
let bubbleButtonColour = UIColor(red:0.78, green:0.83, blue:0.88, alpha:1.0)

let bubbleGameBackgroundColour = UIColor(red:0.92, green:0.91, blue:0.88, alpha:1.0)
let bubbleBallColour = UIColor(red:0.27, green:0.45, blue:0.62, alpha:1.0)
let bubbleHoleColour = UIColor(red:0.74, green:0.72, blue:0.68, alpha:1.0)
