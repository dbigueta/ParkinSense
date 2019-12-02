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

// MARK: Medication Variables
var timePickerTime = ""

var medicationName = "N/A"
var medicationTime = "N/A"
var medicationDate = "N/A"
var medicationLabelAlpha = 0

var medicationName1 = "N/A"
var medicationTime1 = "N/A"
var medicationDate1 = "N/A"
var medicationLabel1Alpha = 0

var medicationName2 = "N/A"
var medicationTime2 = "N/A"
var medicationDate2 = "N/A"
var medicationLabel2Alpha = 0

var medicationName3 = "N/A"
var medicationTime3 = "N/A"
var medicationDate3 = "N/A"
var medicationLabel3Alpha = 0

var medicationName4 = "N/A"
var medicationTime4 = "N/A"
var medicationDate4 = "N/A"
var medicationLabel4Alpha = 0

var medicationcount = 0


// MARK: Mood Variables
var feeling = "N/A"


// MARK: User Information
var username = ""
var password = ""
var userid = ""


// MARK: Game Information
var maxScoreTodayOne = 0
var maxScoreTodayTwo = 0

var maxScoreSelectedDateOne = 0
var maxScoreSelectedDateTwo = 0

var gamedata1 = 0
var gamedata2 = 0
var gamedata3 = 0
var gamedata4 = 0
var gamedata5 = 0
var gamedata6 = 0
var gamedata7 = 0
var values = [gamedata1, gamedata2, gamedata3, gamedata4, gamedata5, gamedata6, gamedata7]

var gamedata12 = 0
var gamedata22 = 0
var gamedata32 = 0
var gamedata42 = 0
var gamedata52 = 0
var gamedata62 = 0
var gamedata72 = 0
var values1 = [gamedata12, gamedata22, gamedata32, gamedata42, gamedata52, gamedata62, gamedata72]


// MARK: Device Information
var screenHeight = UIScreen.main.bounds.height
var screenWidth = UIScreen.main.bounds.width


/* Shared Constants */
let paddingVal: CGFloat = 10
let textFieldFontSize: CGFloat = 20

let appImageName = "AppLogoImage.png"
let tiltImageName = "tilt.png"
let bubbleImageName = "bubblepop.png"
let gameImageHeight: CGFloat = 170
let bubbleImage = UIImage(named: bubbleImageName)
let tiltImage = UIImage(named: tiltImageName)
let appImage = UIImage(named: appImageName)
let appImageHeaderHeight: CGFloat = 40

let headerLabelHeight: CGFloat = 17
let UIButtonHeight: CGFloat = 45
let textFieldHeight: CGFloat = textFieldFontSize + paddingVal


/* Login View Controller Constants & Colours */
let appImageHeight: CGFloat = 130
let appLabelHeight: CGFloat = 32
let sloganLabelHeight: CGFloat = 17

let rememberPassLabelHeight: CGFloat = 15
let rememberPassLabelTopPadding = textFieldHeight + rememberPassLabelHeight/3

let errorLabelHeight: CGFloat = 20

/* Sign Up View Controller Constants & Colours */
let medicationLabelHeight: CGFloat = 20

/* Medication Detail View Controller Constants & Colours */
let medicationDayLabelHeight: CGFloat = 20
let dayLabelHeight: CGFloat = 17
let medicationTimeLabelHeight: CGFloat = 20
let timePickerHeight: CGFloat = 150
let screenSize = UIScreen.main.bounds
let checkboxDiameter: CGFloat = 25
let sectionWidth = screenSize.width/7
let checkboxHeightDays = sectionWidth - 20
let offset = (sectionWidth - CGFloat(checkboxHeightDays))/2
let medicationLabelWidth = (screenWidth - 64)/3

var loadedInfoTrendline = 0
var infoUpdated = false


/* Home UI Constants*/

let headerFontSize:CGFloat = 20

var weekButtonHeight: CGFloat = 30

var homeDayButtonBorderWidth:CGFloat = 2
var homeDayButtonWidth = screenWidth/4 - 5

var homeGameButtonBorderWidth:CGFloat = 2
var homeGameButtonWidth = screenWidth/2 - 20

var headerHeight:CGFloat = 50
var gameLabelHeight: CGFloat = 30

var signOutViewHeight: CGFloat = 70
var progressViewHeight: CGFloat = 50
var dataScrollViewHeight: CGFloat = 250
var calendarViewHeight: CGFloat = 340
var gameViewHeight: CGFloat = 250

var offsetTopWeekButtons = (screenWidth - (4*homeDayButtonWidth))/5
var offsetBottomWeekButtons = (screenWidth - (3*homeDayButtonWidth) - 2*offsetTopWeekButtons)/2
var offsetGameButtons = (screenWidth - (2*homeGameButtonWidth))/3

var alreadyTappedTodaysDate = false

/* Main UI & Login Colours */
let textColour = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
let buttonTextColour = UIColor(red:0.92, green:0.91, blue:0.88, alpha:1.0)
let buttonColour = UIColor(red:0.27, green:0.45, blue:0.62, alpha:1.0)
let font = UIFont.systemFont(ofSize: 20, weight: .light)
//let selectedDayBackgroundColour = UIColor(red:0.69, green:0.75, blue:0.84, alpha:1.0)

let homeBtnColour = UIColor(red:0.78, green:0.83, blue:0.88, alpha:1.0)
let selectedDayBackgroundColour = UIColor(red:0.27, green:0.45, blue:0.62, alpha:1.0)
let homeButtonFontColour = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)

let textFontSize: CGFloat = 17

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
let tiltBackgroundColour = UIColor(red:1.00, green:0.91, blue:0.86, alpha:1.0)
let tiltTextColour = UIColor(red:0.39, green:0.39, blue:0.39, alpha:1.0)
let tiltButtonColour = UIColor(red:1.00, green:0.58, blue:0.52, alpha:1.0)
let tiltButtonTextColour = UIColor(red:0.39, green:0.39, blue:0.39, alpha:1.0)
let tiltTitleFont = UIFont.systemFont(ofSize: 50, weight: .regular)
let tiltFinalScoreFont = UIFont.systemFont(ofSize: 40, weight: .regular)

let tiltGameBackgroundColour = UIColor(red:1.00, green:0.91, blue:0.86, alpha:1.0)
let tiltBallColour = UIColor(red:1.00, green:0.58, blue:0.52, alpha:1.0)
let tiltHoleColour = UIColor(red:0.70, green:0.73, blue:0.64, alpha:1.0)

let countdownBackgroundColour = UIColor(red:0.39, green:0.39, blue:0.39, alpha:1.0)
let countdownTextColour = UIColor(red:1.00, green:0.91, blue:0.86, alpha:1.0)


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
let bubbleBackgroundColour = UIColor(red:0.91, green:0.96, blue:0.85, alpha:1.0)
let bubbleTextColour = UIColor(red:0.30, green:0.26, blue:0.36, alpha:1.0)
let bubbleButtonColour = UIColor(red:0.76, green:0.85, blue:0.79, alpha:1.0)

let bubbleGameBackgroundColour = UIColor(red:0.84, green:0.95, blue:0.83, alpha:1.0)
let bubbleBallColour = UIColor(red:0.20, green:0.38, blue:0.35, alpha:1.0)

let countdownBubbleBackgroundColour = UIColor(red:0.30, green:0.26, blue:0.36, alpha:1.0)
let countdownBubbleTextColour = UIColor(red:0.91, green:0.96, blue:0.85, alpha:1.0)
