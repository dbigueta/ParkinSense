//-----------------------------------------------------------------
//  File: HomeViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng, Hamlet Jiang Su
//
//  Description: Displays the home view of Parkinsense, including trendline, calendar, and game buttons
//
//  Changes:
//      - Refactored code to programmatically code UI elements
//      - Added the swipe and page control
//      - Modified the gaming icon
//
//  Known Bugs:
//      - Does not highlight todays date when homeview is first presented
//
//-----------------------------------------------------------------

import UIKit
import Charts
import FirebaseDatabase
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController, UIScrollViewDelegate{
    
    var ref: DatabaseReference?
    
    //Obtain current year
    var currentYear = Calendar.current.component(.year, from: Date())
    
    // Obtain current week #
    var currentWeek = Calendar.current.component(.weekOfYear, from: Date())
    
    // Current Date and Time
    var rightNow = Date()
    
    // Database access for Firebase
    let db = Firestore.firestore()
    
    // Scroll view to allow scrolling of content
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // Container that keeps all the scrollable content
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical // Set content stacking
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Progress view that contains the progress label
    let signOutView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true // enables user interaction
        view.heightAnchor.constraint(equalToConstant: signOutViewHeight).isActive = true
        return view
    }()
    
    // Sign Out Button
    let signOutButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button) // Styles button
        button.setTitle("S I G N    O U T", for: .normal) // Set button label
        button.layer.cornerRadius = 0 // Set the button to be rectangular
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium) // Set font size
        button.addTarget(self, action: #selector(signOutTapped(_:)), for: .touchUpInside) // Set function to be triggered if tapped
        return button
    }()
    
    // Progress view that contains the progress label
    let progressView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: progressViewHeight).isActive = true // Set height
        return view
    }()
    
    // Progress UI label
    let progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Weekly Progress" // Set text label
        label.textAlignment = .center // Set text alignment
        label.font = UIFont.systemFont(ofSize: headerFontSize, weight: .medium) // Set label font
        label.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true // Set label height
        return label
    }()
    
    // Data scroll view that contains the trendline and the day information
    let dataScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.heightAnchor.constraint(equalToConstant: dataScrollViewHeight).isActive = true // Set label height
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true // Set pages for scroll view
        return scrollView
    }()
    
    // Date UI label
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date" // Set label text
        label.textAlignment = .left // Set label text alignment
        label.font = UIFont.systemFont(ofSize: textFontSize, weight: .regular) // Set label font
        return label
    }()

    // Medication UI label
    let medLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Medication 1" // Set label text
        label.textAlignment = .left // Set label text alignment
        label.font = UIFont.systemFont(ofSize: textFontSize, weight: .regular) // Set label font
        return label
    }()
    
    // Medication UI label
    let medLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Medication 2" // Set label text
        label.textAlignment = .left // Set label text alignment
        label.font = UIFont.systemFont(ofSize: textFontSize, weight: .regular) // Set label font
        return label
    }()
    
    // Medication UI label
    let medLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Medication 3" // Set label text
        label.textAlignment = .left // Set label text alignment
        label.font = UIFont.systemFont(ofSize: textFontSize, weight: .regular) // Set label font
        return label
    }()
    
    // Medication UI label
    let medLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Medication 4" // Set label text
        label.textAlignment = .left // Set label text alignment
        label.font = UIFont.systemFont(ofSize: textFontSize, weight: .regular) // Set label font
        return label
    }()
    
    // Medication UI label
    let medLabel4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Medication 5" // Set label text
        label.textAlignment = .left // Set label text alignment
        label.font = UIFont.systemFont(ofSize: textFontSize, weight: .regular) // Set label font
        return label
    }()
    
    // Tilt UI label
    let tiltGameScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tilt Game Score" // Set label text
        label.textAlignment = .left // Set label text alignment
        label.font = UIFont.systemFont(ofSize: textFontSize, weight: .regular) // Set label font
        return label
    }()
    
    // Bubble Pop UI label
    let bubbleGameScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bubble Game Score" // Set label text
        label.textAlignment = .left // Set label text alignment
        label.font = UIFont.systemFont(ofSize: textFontSize, weight: .regular) // Set label font
        return label
    }()
    
    // Mood UI label
    let moodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mood" // Set label text
        label.textAlignment = .left // Set label text alignment
        label.font = UIFont.systemFont(ofSize: textFontSize, weight: .regular) // Set label font
        return label
    }()
    
    var lineChartView: LineChartView!
    var lineChartView1: LineChartView!
    
    // Allows for a consistent switch between trendline and day information
    let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.pageIndicatorTintColor = .gray // Set page control colour
        page.currentPageIndicatorTintColor = .black // Set active page control colour
        page.numberOfPages = 3 // Set number of pages for trendline and daily data
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()
    
    // Calendar view that displays the days of the week, and the next/prev buttons
    let calendarView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: calendarViewHeight).isActive = true // Set view height
        return view
    }()
    
    // Week header UI label
    let weekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Week Select" // Set label text
        label.textAlignment = .center // Set label text alignment
        label.font = UIFont.systemFont(ofSize: headerFontSize, weight: .medium) // Set label font
        label.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true // Set font height
        return label
    }()
    
    // Prev week button
    let prevWeek: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("< Prev", for: .normal) // Set button label text
        button.contentHorizontalAlignment = .left // Set button label text alignment
        button.setTitleColor(homeButtonFontColour, for: .normal) // Set button label colour
        button.addTarget(self, action: #selector(prevWeekButtonPressed(_:)), for: .touchUpInside) // Set function to trigger if tapped
        button.widthAnchor.constraint(equalToConstant: screenWidth/3).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: weekButtonHeight).isActive = true // Set button height
        return button
    }()
    
    // Date range UI Label
    let weekDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date Range" // Set label text
        label.textAlignment = .center // Set label text alignment
        label.widthAnchor.constraint(equalToConstant: screenWidth/3).isActive = true // Set label width
        label.heightAnchor.constraint(equalToConstant: weekButtonHeight).isActive = true // Set label height
        return label
    }()
    
    // Next week button
    let nextWeek: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next >", for: .normal) // Set button label text
        button.contentHorizontalAlignment = .right // Set button label text alignment
        button.setTitleColor(homeButtonFontColour, for: .normal) // Set button label colour
        button.addTarget(self, action: #selector(nextWeekButtonPressed(_:)), for: .touchUpInside) // Set function to trigger if tapped
        button.widthAnchor.constraint(equalToConstant: screenWidth/3).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: weekButtonHeight).isActive = true // Set button height
        return button
    }()
    
    // Sunday button
    let sundayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(homeButtonFontColour, for: .normal) // Set button text colour
        button.layer.borderWidth = homeDayButtonBorderWidth // Set button border width
        button.layer.cornerRadius = 5 // Set button to be rounded corners
        button.backgroundColor = homeBtnColour // Set button background colour
        button.addTarget(self, action: #selector(sundayDateSelected(_:)), for: .touchUpInside) // Set function to trigger if tapped
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true  // Set button width
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button height
        //button.layer.borderColor = UIColor(red:0.75, green:0.85, blue:0.84, alpha:1.0).cgColor
        return button
    }()
    
    // Monday button
    let mondayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(homeButtonFontColour, for: .normal) // Set button text colour
        button.layer.borderWidth = homeDayButtonBorderWidth // Set button border width
        button.layer.cornerRadius = 5 // Set button to be rounded corners
        button.backgroundColor = homeBtnColour // Set button background colour
        button.addTarget(self, action: #selector(mondayDateSelected(_:)), for: .touchUpInside) // Set function to trigger if tapped
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button height
        return button
    }()
    
    // Tuesday button
    let tuesdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(homeButtonFontColour, for: .normal) // Set button text colour
        button.layer.borderWidth = homeDayButtonBorderWidth // Set button border width
        button.layer.cornerRadius = 5 // Set button to be rounded corners
        button.backgroundColor = homeBtnColour // Set button background colour
        button.addTarget(self, action: #selector(tuesdayDateSelected(_:)), for: .touchUpInside) // Set function to trigger if tapped
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button height
        return button
    }()
    
    // Wednesday button
    let wednesdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(homeButtonFontColour, for: .normal) // Set button text colour
        button.layer.borderWidth = homeDayButtonBorderWidth // Set button border width
        button.layer.cornerRadius = 5 // Set button to be rounded corners
        button.backgroundColor = homeBtnColour // Set button background colour
        button.addTarget(self, action: #selector(wednesdayDateSelected(_:)), for: .touchUpInside) // Set function to trigger if tapped
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button height
        return button
    }()
    
    // Thursday button
    let thursdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(homeButtonFontColour, for: .normal) // Set button text colour
        button.layer.borderWidth = homeDayButtonBorderWidth // Set button border width
        button.layer.cornerRadius = 5 // Set button to be rounded corners
        button.backgroundColor = homeBtnColour // Set button background colour
        button.addTarget(self, action: #selector(thursdayDateSelected(_:)), for: .touchUpInside) // Set function to trigger if tapped
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button height
        return button
    }()
    
    // Friday button
    let fridayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(homeButtonFontColour, for: .normal) // Set button text colour
        button.layer.borderWidth = homeDayButtonBorderWidth // Set button border width
        button.layer.cornerRadius = 5 // Set button to be rounded corners
        button.backgroundColor = homeBtnColour // Set button background colour
        button.addTarget(self, action: #selector(fridayDateSelected(_:)), for: .touchUpInside) // Set function to trigger if tapped
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button height
        return button
    }()
    
    // Saturday button
    let saturdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(homeButtonFontColour, for: .normal) // Set button text colour
        button.layer.borderWidth = homeDayButtonBorderWidth // Set button border width
        button.layer.cornerRadius = 5 // Set button to be rounded corners
        button.backgroundColor = homeBtnColour // Set button background colour
        button.addTarget(self, action: #selector(saturdayDateSelected(_:)), for: .touchUpInside) // Set function to trigger if tapped
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true // Set button height
        return button
    }()
    
    // Game view that contains the two buttons to initiate the games
    let gameView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: gameViewHeight).isActive = true // Set view height
        return view
    }()
    
    // Game header UI label
    let gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Game Selection" // Set label text
        label.textAlignment = .center // Set label text alignment
        label.font = UIFont.systemFont(ofSize: headerFontSize, weight: .medium) // Set label font
        label.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        return label
    }()
    
    // Tilt button
    let tiltButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(tiltButtonColour, for: .normal) // Set button text colour
        button.layer.borderWidth = homeGameButtonBorderWidth // Set button border width
        button.layer.cornerRadius = 5 // Set button to be rounded corners
        button.backgroundColor = tiltBackgroundColour // Set button background colour
        button.setImage(UIImage(named: "tiltBtn.png"), for: .normal) // Set button image
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25) // Set button image padding
        //button.setTitle("Tilt", for: .normal)
        button.addTarget(self, action: #selector(tiltButtonPressed(_:)), for: .touchUpInside) // Set function to trigger if tapped
        button.widthAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true // Set button height
        return button
    }()
    
    // Bubble Pop button
    let bubblePopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal) // Set button text colour
        button.layer.borderWidth = homeGameButtonBorderWidth // Set button border width
        button.layer.cornerRadius = 5 // Set button to be rounded corners
        button.backgroundColor = bubbleBackgroundColour // Set button background colour
        button.setImage(UIImage(named: "bubbleBtn.png"), for: .normal) // Set button image
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 20, bottom: 15, right: 20) // Set button image padding
        //button.setTitle("Bubble Pop", for: .normal)
        button.addTarget(self, action: #selector(bubblePopButtonPressed(_:)), for: .touchUpInside) // Set function to trigger if tapped
        button.widthAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true // Set button height
        return button
    }()
    
    // MARK: Class Functions
    
    
    /**
     Function that adds all UI elements to the view and sets up all constraints for each UI element
     
     - Returns: None
     **/
    override func loadView(){
        super.loadView()
        
        // Add signout button to signout view
        signOutView.addSubview(signOutButton)
        
        // Add label to progressView view
        progressView.addSubview(progressLabel)
        
        // Add all respective labels to data scroll view
        dataScrollView.addSubview(dateLabel)
        dataScrollView.addSubview(medLabel)
        dataScrollView.addSubview(medLabel1)
        dataScrollView.addSubview(medLabel2)
        dataScrollView.addSubview(medLabel3)
        dataScrollView.addSubview(medLabel4)
        dataScrollView.addSubview(tiltGameScore)
        dataScrollView.addSubview(bubbleGameScore)
        dataScrollView.addSubview(moodLabel)
        
        // Add all respective labels, buttons, and page controls to calendar view
        calendarView.addSubview(pageControl)
        calendarView.addSubview(weekLabel)
        calendarView.addSubview(prevWeek)
        calendarView.addSubview(weekDateLabel)
        calendarView.addSubview(nextWeek)
        calendarView.addSubview(sundayButton)
        calendarView.addSubview(mondayButton)
        calendarView.addSubview(tuesdayButton)
        calendarView.addSubview(wednesdayButton)
        calendarView.addSubview(thursdayButton)
        calendarView.addSubview(fridayButton)
        calendarView.addSubview(saturdayButton)
        
        // Add all respective buttons and labels to game view
        gameView.addSubview(gameLabel)
        gameView.addSubview(tiltButton)
        gameView.addSubview(bubblePopButton)
        
        // Place each view in its proper location on the screen
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(signOutView)
        scrollViewContainer.addArrangedSubview(progressView)
        scrollViewContainer.addArrangedSubview(dataScrollView)
        scrollViewContainer.addArrangedSubview(calendarView)
        scrollViewContainer.addArrangedSubview(gameView)
        
        // Set scroll view constraints to allow for scrollable content
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Set sign out view constraints to allow for multiple device configurations
        signOutView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        signOutView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        signOutView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        
        // Set sign out button constraints to allow for multiple device configurations
        signOutButton.topAnchor.constraint(equalTo: signOutView.topAnchor).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: signOutViewHeight).isActive = true
        signOutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        signOutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        // Set scroll view container constraints to allow content to scroll based on device height
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        // Set date label constraints to allow for multiple device configurations
        dateLabel.leadingAnchor.constraint(equalTo: dataScrollView.leadingAnchor, constant: screenWidth * 2 +  24.0).isActive = true
        dateLabel.topAnchor.constraint(equalTo: dataScrollView.topAnchor, constant: (dataScrollViewHeight - 9*textFontSize - 64.0)/2).isActive = true
        
        // Set medication label constraints to allow for multiple device configurations
        medLabel.leadingAnchor.constraint(equalTo: dataScrollView.leadingAnchor, constant: screenWidth * 2 +  24.0).isActive = true
        medLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: textFontSize + 8.0).isActive = true
        
        // Set medication 2 label constraints to allow for multiple device configurations
        medLabel1.leadingAnchor.constraint(equalTo: dataScrollView.leadingAnchor, constant: screenWidth * 2 +  24.0).isActive = true
        medLabel1.topAnchor.constraint(equalTo: medLabel.topAnchor, constant: textFontSize + 8.0).isActive = true
        
        // Set medication 3 label constraints to allow for multiple device configurations
        medLabel2.leadingAnchor.constraint(equalTo: dataScrollView.leadingAnchor, constant: screenWidth * 2 +  24.0).isActive = true
        medLabel2.topAnchor.constraint(equalTo: medLabel1.topAnchor, constant: textFontSize + 8.0).isActive = true
        
        // Set medication 4 label constraints to allow for multiple device configurations
        medLabel3.leadingAnchor.constraint(equalTo: dataScrollView.leadingAnchor, constant: screenWidth * 2 +  24.0).isActive = true
        medLabel3.topAnchor.constraint(equalTo: medLabel2.topAnchor, constant: textFontSize + 8.0).isActive = true
        
        // Set medication 5 label constraints to allow for multiple device configurations
        medLabel4.leadingAnchor.constraint(equalTo: dataScrollView.leadingAnchor, constant: screenWidth * 2 +  24.0).isActive = true
        medLabel4.topAnchor.constraint(equalTo: medLabel3.topAnchor, constant: textFontSize + 8.0).isActive = true
        
        // Set tilt score label constraints to allow for multiple device configurations
        tiltGameScore.leadingAnchor.constraint(equalTo: dataScrollView.leadingAnchor, constant: screenWidth * 2 +  24.0).isActive = true
        tiltGameScore.topAnchor.constraint(equalTo: medLabel4.topAnchor, constant: textFontSize + 8.0).isActive = true
        
        // Set bubble pop label constraints to allow for multiple device configurations
        bubbleGameScore.leadingAnchor.constraint(equalTo: dataScrollView.leadingAnchor, constant: screenWidth * 2 +  24.0).isActive = true
        bubbleGameScore.topAnchor.constraint(equalTo: tiltGameScore.topAnchor, constant: textFontSize + 8.0).isActive = true
        
        // Set mood label constraints to allow for multiple device configurations
        moodLabel.leadingAnchor.constraint(equalTo: dataScrollView.leadingAnchor, constant: screenWidth * 2 +  24.0).isActive = true
        moodLabel.topAnchor.constraint(equalTo: bubbleGameScore.topAnchor, constant: textFontSize + 8.0).isActive = true
        
        // Set progress label constraints to allow for multiple device configurations
        progressLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 16.0).isActive = true
        progressLabel.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: -16.0).isActive = true
        progressLabel.topAnchor.constraint(equalTo: progressView.topAnchor).isActive = true
        
        // Set page controls constraints to allow for multiple device configurations
        pageControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.0).isActive = true
        pageControl.topAnchor.constraint(equalTo: dataScrollView.topAnchor, constant: dataScrollViewHeight - 4.0).isActive = true
        
        // Set week select label constraints to allow for multiple device configurations
        weekLabel.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 16.0).isActive = true
        weekLabel.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: -16.0).isActive = true
        weekLabel.topAnchor.constraint(equalTo: calendarView.topAnchor, constant: 24.0).isActive = true
        
        // Set prev week button constraints to allow for multiple device configurations
        prevWeek.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 8.0).isActive = true
        prevWeek.topAnchor.constraint(equalTo: weekLabel.topAnchor, constant: headerHeight).isActive = true
        
        // Set week range label constraints to allow for multiple device configurations
        weekDateLabel.leadingAnchor.constraint(equalTo: prevWeek.leadingAnchor, constant: screenWidth/3).isActive = true
        weekDateLabel.topAnchor.constraint(equalTo: weekLabel.topAnchor, constant: headerHeight).isActive = true
        
        // Set next week button constraints to allow for multiple device configurations
        nextWeek.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: -8.0).isActive = true
        nextWeek.topAnchor.constraint(equalTo: weekLabel.topAnchor, constant: headerHeight).isActive = true
        
        // Set day button constraints to allow for multiple device configurations
        sundayButton.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: offsetTopWeekButtons).isActive = true
        sundayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 24.0).isActive = true
        
        // Set day button constraints to allow for multiple device configurations
        mondayButton.leadingAnchor.constraint(equalTo: sundayButton.leadingAnchor, constant: homeDayButtonWidth + offsetTopWeekButtons).isActive = true
        mondayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 24.0).isActive = true
        
        // Set day button constraints to allow for multiple device configurations
        tuesdayButton.leadingAnchor.constraint(equalTo: mondayButton.leadingAnchor, constant: homeDayButtonWidth + offsetTopWeekButtons).isActive = true
        tuesdayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 24.0).isActive = true
        
        // Set day button constraints to allow for multiple device configurations
        wednesdayButton.leadingAnchor.constraint(equalTo: tuesdayButton.leadingAnchor, constant: homeDayButtonWidth + offsetTopWeekButtons).isActive = true
        wednesdayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 24.0).isActive = true
        
        // Set day button constraints to allow for multiple device configurations
        thursdayButton.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: offsetBottomWeekButtons).isActive = true
        thursdayButton.topAnchor.constraint(equalTo: sundayButton.topAnchor, constant: homeDayButtonWidth + 16.0).isActive = true
        
        // Set day button constraints to allow for multiple device configurations
        fridayButton.leadingAnchor.constraint(equalTo: thursdayButton.leadingAnchor, constant: homeDayButtonWidth + offsetTopWeekButtons).isActive = true
        fridayButton.topAnchor.constraint(equalTo: sundayButton.topAnchor, constant: homeDayButtonWidth + 16.0).isActive = true
        
        // Set day button constraints to allow for multiple device configurations
        saturdayButton.leadingAnchor.constraint(equalTo: fridayButton.leadingAnchor, constant: homeDayButtonWidth + offsetTopWeekButtons).isActive = true
        saturdayButton.topAnchor.constraint(equalTo: sundayButton.topAnchor, constant: homeDayButtonWidth + 16.0).isActive = true
        
        // Set game select header constraints to allow for multiple device configurations
        gameLabel.leadingAnchor.constraint(equalTo: gameView.leadingAnchor, constant: 16.0).isActive = true
        gameLabel.trailingAnchor.constraint(equalTo: gameView.trailingAnchor, constant: -16.0).isActive = true
        gameLabel.topAnchor.constraint(equalTo: gameView.topAnchor).isActive = true
        
        // Set tilt game button constraints to allow for multiple device configurations
        tiltButton.leadingAnchor.constraint(equalTo: gameView.leadingAnchor, constant: offsetGameButtons).isActive = true
        tiltButton.topAnchor.constraint(equalTo: gameLabel.topAnchor, constant: headerHeight + 16.0).isActive = true
        
        // Set bubble pop button constraints to allow for multiple device configurations
        bubblePopButton.leadingAnchor.constraint(equalTo: tiltButton.leadingAnchor, constant: homeGameButtonWidth + offsetGameButtons).isActive = true
        bubblePopButton.topAnchor.constraint(equalTo: gameLabel.topAnchor, constant: headerHeight + 16.0).isActive = true
    }
    
    
    /**
     Function that sets up navigation bar properties and sets up user data
     
     - Returns: None
     **/
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Sets the scroll view to start at the weekly progress instead of sign out button
        self.view.layoutIfNeeded()
        let newOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + signOutViewHeight)
        scrollView.setContentOffset(newOffset, animated: false)
        
        // Set background colour of the view
        self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
        setupUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateInformation() // Updates information on the daily data trendline
    }
    
    /**
     Function that sets up user data for buttons and labels
     
     - Returns: None
     */
    func setupUserData() {
        
        // Sets up date range for the weekly calendar section
        setUp(newformattedtartcurrentweek: formattedStartCurrentWeek, newformattedendcurrentweek: formattedEndCurrentWeek)
        
        // Retrieves week dates and updates buttons with those dates
        sevenDayDate(currentdate: rightNow)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormatter.string(from: rightNow)
        
        // Highlights the current selected date
        highlightSelectedDate()
        
        // Retrieves uid of the current user from Firebase
        userid = Auth.auth().currentUser!.uid
        
        // Retrieves user data from Firebase
        db.collection("users").document(userid).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists {
                    
                    // Contains the user data
                    let DocumentData = document!.data()
                    
                    // Retrieve username
                    username = DocumentData!["Username"] as! String
                    
                    // Retrieve medication names
                    medicationName = DocumentData!["MedicationName"] as! String
                    medicationName1 = DocumentData!["MedicationName1"] as! String
                    medicationName2 = DocumentData!["MedicationName2"] as! String
                    medicationName3 = DocumentData!["MedicationName3"] as! String
                    medicationName4 = DocumentData!["MedicationName4"] as! String
                    
                    // Retreives medication times
                    medicationTime = DocumentData!["MedicationTime"] as! String
                    medicationTime1 = DocumentData!["MedicationTime1"] as! String
                    medicationTime2 = DocumentData!["MedicationTime2"] as! String
                    medicationTime3 = DocumentData!["MedicationTime3"] as! String
                    medicationTime4 = DocumentData!["MedicationTime4"] as! String
                    
                    // Retrieves medication dates
                    medicationDate = DocumentData!["MedicationDate"] as! String
                    medicationDate1 = DocumentData!["MedicationDate1"] as! String
                    medicationDate2 = DocumentData!["MedicationDate2"] as! String
                    medicationDate3 = DocumentData!["MedicationDate3"] as! String
                    medicationDate4 = DocumentData!["MedicationDate4"] as! String
                    
                    // Retrieves game scores
                    maxScoreSelectedDateOne = DocumentData!["Game_One_lastMaxScore"] as! Int
                    maxScoreSelectedDateOne = DocumentData!["Game_Two_lastMaxScore"] as! Int
                    
                    // Retrieves mood
                    feeling = DocumentData!["feeling"] as! String
                    
                    // Obtain last login date
                    let lastTimeLogin = DocumentData!["login_time"] as! Timestamp
                    let lastTimeLoginDate = lastTimeLogin.dateValue()
                    
                    // Set up correct date format
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    lastTimeLoginDateStr = dateFormatter.string(from: lastTimeLoginDate)
                    thisTimeLoginDateStr = dateFormatter.string(from: Date())
                    
                    // Check if the user is the first time login, if so, the pops up will be activated
                    if lastTimeLoginDateStr != thisTimeLoginDateStr {
                        if medicationName != "N/A" { self.popoverMedication(haveMedication: true) }
                        else { self.popoverMedication(haveMedication: false) }
                    }
                    
                    self.updateInformation()
                }
            }
        }
    }
    
    
    /**
     Function that sets up the daily pop up notification for medication
     
     - Parameters: haveMedication Bool
     - Returns: None
     **/
    func popoverMedication(haveMedication: Bool){
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Performs medication alert only if there was medication inputted
        if haveMedication == true {
            // Create a new alert controller to display alerts
            let alert = UIAlertController(title: "Medicine Reminder", message: "Did you take your medicine today?", preferredStyle: .alert)
            
            // Add alert option
            alert.addAction(UIAlertAction(title: "Yes", style: .default) {Void in
                self.popoverFeeling() // Make mood popup appear
            })
            
            // Add alert option
            alert.addAction(UIAlertAction(title: "No", style: .default) {Void in
                self.popoverFeeling() // Make mood popup appear
            })
            
            self.present(alert,animated: true)
        }
        else {
            popoverFeeling() // Make mood popup appear
        }
    }
    
    
    /**
     Function that sets up the daily pop up notification for mood
     
     - Returns: String containing selected mood
     **/
    func popoverFeeling(){
        var mood = ""
        
        // Create a new alert controller to display alerts
        let alert = UIAlertController(title: "Daily Mood", message: "What is your current mood?", preferredStyle: .alert)
        
        // Add alert options for happy option and updates the database and info within the app
        alert.addAction(UIAlertAction(title: "Happy", style: .default) {Void in mood = "Happy"; self.syncDatabase(mood: mood)})
        
        // Add alert options for excited option and updates the database and info within the app
        alert.addAction(UIAlertAction(title: "Excited", style: .default) {Void in mood = "Excited"; self.syncDatabase(mood: mood)})
        
        // Add alert options for calm option and updates the database and info within the app
        alert.addAction(UIAlertAction(title: "Calm", style: .default) {Void in mood = "Calm"; self.syncDatabase(mood: mood)})
        
        // Add alert options for anxious option and updates the database and info within the app
        alert.addAction(UIAlertAction(title: "Anxious", style: .default) {Void in mood = "Anxious"; self.syncDatabase(mood: mood)})
        
        // Add alert options for sad option and updates the database and info within the app
        alert.addAction(UIAlertAction(title: "Sad", style: .default) {Void in mood = "Sad"; self.syncDatabase(mood: mood)})
        
        // Add alert options for angry option and updates the database and info within the app
        alert.addAction(UIAlertAction(title: "Angry", style: .default) {Void in mood = "Angry"; self.syncDatabase(mood: mood)})
        
        self.present(alert,animated: true)
    }
    
    
    /**
     Function that syncs up the firebase database when there is a change in local data
     
     - Parameters: String containing selected mood
     **/
    func syncDatabase(mood: String) {
        let currentTimeDate = dateFormatter.string(from: Date())
        feeling = mood
        self.moodLabel.text = "Mood:  " + mood
        
        // Updates the Firebase database
        self.db.collection("users").document(userid).collection("gaming_score").document(currentTimeDate).setData([
            "date":thisTimeLoginDateStr,
            "Game_One_lastMaxScore":0,
            "Game_Two_lastMaxScore":0,
            "feeling": mood
        ]);
        
        // Updates the Firebase database
        db.collection("users").document(userid).setData([
                "login_time": rightNow,
                   "Username": username,
                   "uid": userid,
                   "MedicationName": medicationName,
                   "MedicationDate": medicationDate,
                   "MedicationTime": medicationTime,
                   "MedicationName1": medicationName1,
                   "MedicationDate1": medicationDate1,
                   "MedicationTime1": medicationTime1,
                   "MedicationName2": medicationName2,
                   "MedicationDate2": medicationDate2,
                   "MedicationTime2": medicationTime2,
                   "MedicationName3": medicationName3,
                   "MedicationDate3": medicationDate3,
                   "MedicationTime3": medicationTime3,
                   "MedicationName4": medicationName4,
                   "MedicationDate4": medicationDate4,
                   "MedicationTime4": medicationTime4,
                   "Game_One_lastMaxScore": maxScoreTodayOne,
                   "Game_Two_lastMaxScore": maxScoreTodayTwo,
                   "feeling": mood
        ]){ (error) in
            if error != nil {
                //Show error message
                self.moodLabel.text = "Mood:  " + mood
            }
        }
    }
    
    
    /**
     Function for displaying next week date by clicking the next week button
     
     - Parameters: Button itself
     - Returns: None
     **/
    @objc func nextWeekButtonPressed(_ sender: Any) {
        // Obtain next week's date
        let nextweek = rightNow + 3600*24*7
        rightNow = nextweek
        
        // Retrieve the days for the next week
        sevenDayDate(currentdate: rightNow)
        
        // Get the first date of the choosen week
        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow)
        
        // Get the end date of the choosen week
        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow)
        
        // Record the current week of the year
        currentWeek += 1
        
        // Only 52 weeks/year, reset to first week
        if currentWeek == 53 {
            currentWeek = 1
            currentYear += 1
        }
        
        // Redraw the current week's appearance buttons
        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
        
        highlightSelectedDate()
    }
    
    
    /**
     Function for displaying prev week date by clicking the next week button
     
     - Parameters: Button itself
     - Returns: None
     **/
    @objc func prevWeekButtonPressed(_ sender: Any) {
        // Obtain next week's date
        let nextweek = rightNow - 3600*24*7
        rightNow = nextweek
        
        // Retrieve the days for the next week
        sevenDayDate(currentdate: rightNow)
        
        // Get the first date of the choosen week
        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow)
        
        // Get the end date of the choosen week
        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow)
        
        // Record the current week of the year
        currentWeek -= 1
        
        // Only 52 weeks/year, reset to last week
        if currentWeek == 0 {
            currentWeek = 52
            currentYear -= 1
        }
        
        // Redraw the current week's appearance buttons
        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
        
        highlightSelectedDate()
    }
    
    
    /**
     Function to determine week range on calendar
     
     - Parameter newformattedtartcurrentweek: String
     - Parameter newformattedendcurrentweek: String
     - Returns: None
     **/
    func setUp(newformattedtartcurrentweek: String, newformattedendcurrentweek: String)
    {
        weekDateLabel.text = "\(newformattedtartcurrentweek)" + " ~ " + "\(newformattedendcurrentweek)"
    }
    
    
    /**
     Function to update the dates of the weekly calendar
     
     - Parameter currentdate: Date
     - Returns: None
     **/
    func sevenDayDate(currentdate: Date){
        // Get the corresponding date of the days
        let SundayDate = sundayDate(startCurrentWeek: currentdate)
        let MondayDate = mondayDate(startCurrentWeek: currentdate)
        let TuesdayDate = tuesdayDate(startCurrentWeek: currentdate)
        let WednesdayDate = wednesdayDate(startCurrentWeek: currentdate)
        let ThursdayDate = thursdayDate(startCurrentWeek: currentdate)
        let FridayDate = fridayDate(startCurrentWeek: currentdate)
        let SaturdayDate = saturdayDate(startCurrentWeek: currentdate)
        
        // Set title of the buttons text
        sundayButton.setTitle(SundayDate, for: .normal)
        mondayButton.setTitle(MondayDate, for: .normal)
        tuesdayButton.setTitle(TuesdayDate, for: .normal)
        wednesdayButton.setTitle(WednesdayDate, for: .normal)
        thursdayButton.setTitle(ThursdayDate, for: .normal)
        fridayButton.setTitle(FridayDate, for: .normal)
        saturdayButton.setTitle(SaturdayDate, for: .normal)
    }
    
    
    /**
     Function that highlights the current selected date
     
     - Returns: None
     **/
    func highlightSelectedDate(){
        // Resets all button colours
        sundayButton.backgroundColor = homeBtnColour
        mondayButton.backgroundColor = homeBtnColour
        tuesdayButton.backgroundColor = homeBtnColour
        wednesdayButton.backgroundColor = homeBtnColour
        thursdayButton.backgroundColor = homeBtnColour
        fridayButton.backgroundColor = homeBtnColour
        saturdayButton.backgroundColor = homeBtnColour
        
        // Resets all font weights of the buttons
        sundayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        mondayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        tuesdayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        wednesdayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        thursdayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        fridayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        saturdayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        
        // Resets all button background colours
        sundayButton.setTitleColor(homeButtonFontColour, for: .normal)
        mondayButton.setTitleColor(homeButtonFontColour, for: .normal)
        tuesdayButton.setTitleColor(homeButtonFontColour, for: .normal)
        wednesdayButton.setTitleColor(homeButtonFontColour, for: .normal)
        thursdayButton.setTitleColor(homeButtonFontColour, for: .normal)
        fridayButton.setTitleColor(homeButtonFontColour, for: .normal)
        saturdayButton.setTitleColor(homeButtonFontColour, for: .normal)
        
        // Sets the background of the current selected date
        if selectedDate == sundayDatewithMY{
            sundayButton.backgroundColor = selectedDayBackgroundColour // Set background colour to indicate current selection
            sundayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold) // Set button font weight to bold to indicate current selection
            sundayButton.setTitleColor(buttonTextColour, for: .normal)
        }
        if selectedDate == mondayDatewithMY{
            mondayButton.backgroundColor = selectedDayBackgroundColour // Set background colour to indicate current selection
            mondayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold) // Set button font weight to bold to indicate current selection
            mondayButton.setTitleColor(buttonTextColour, for: .normal)
        }
        if selectedDate == tuesdayDatewithMY{
            tuesdayButton.backgroundColor = selectedDayBackgroundColour // Set background colour to indicate current selection
            tuesdayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold) // Set button font weight to bold to indicate current selection
            tuesdayButton.setTitleColor(buttonTextColour, for: .normal)
        }
        if selectedDate == wednesdayDatewithMY{
            wednesdayButton.backgroundColor = selectedDayBackgroundColour // Set background colour to indicate current selection
            wednesdayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold) // Set button font weight to bold to indicate current selection
            wednesdayButton.setTitleColor(buttonTextColour, for: .normal)
        }
        if selectedDate == thursdayDatewithMY{
            thursdayButton.backgroundColor = selectedDayBackgroundColour // Set background colour to indicate current selection
            thursdayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold) // Set button font weight to bold to indicate current selection
            thursdayButton.setTitleColor(buttonTextColour, for: .normal)
        }
        if selectedDate == fridayDatewithMY{
            fridayButton.backgroundColor = selectedDayBackgroundColour // Set background colour to indicate current selection
            fridayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold) // Set button font weight to bold to indicate current selection
            fridayButton.setTitleColor(buttonTextColour, for: .normal)
        }
        if selectedDate == saturdayDatewithMY{
            saturdayButton.backgroundColor = selectedDayBackgroundColour // Set background colour to indicate current selection
            saturdayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold) // Set button font weight to bold to indicate current selection
            saturdayButton.setTitleColor(buttonTextColour, for: .normal)
        }
    }
    
    
    /**
     Function that sets up the trendline and daily data information
     
     - Parameter currentdate: String
     - Returns: None
     **/
    func setupTrendline(currentDate: String){
        
        // remove current trendlines from the screen
        lineChartView?.removeFromSuperview()
        lineChartView1?.removeFromSuperview()
        
        // Sets up relative positions of the trendlines
        let x1Pos = CGFloat(0) * screenWidth
        let x3Pos = CGFloat(1) * screenWidth
        
        // Holds trendline data entries for the past 7 days
        var dataEntries: [ChartDataEntry] = []
        var dataEntries1: [ChartDataEntry] = []
        
        // Set up line chart to the corresponding locations
        lineChartView = LineChartView(frame: CGRect(x: x1Pos, y: 0, width: screenWidth, height: dataScrollViewHeight))
        lineChartView1 = LineChartView(frame: CGRect(x: x3Pos, y: 0, width: screenWidth, height: dataScrollViewHeight))
        
        // Retrieve last seven days
        selectedDateinDatetype = dateFormatter.date(from: selectedDate)
        pastSevenDatefunc(currentSelectedDate: selectedDateinDatetype!)
        
        lineChartView.isUserInteractionEnabled = false // Stops user from interacting with trendline
        lineChartView.leftAxis.axisMinimum = 0 // Sets the axis minimum
        lineChartView.rightAxis.enabled = false // Removes right axis
        lineChartView.xAxis.spaceMin = 0.5 // Sets padding of x-axis
        lineChartView.xAxis.spaceMax = 0.5 // Sets padding of x-axis
        lineChartView.xAxis.drawGridLinesEnabled = false // Removes gridlines
        lineChartView.legend.font = UIFont.systemFont(ofSize: 15) // Sets the legend font size
        lineChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 12) // Sets the axis font size
        lineChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 12) // Sets the yaxis font size
        
        // Sets the x axis labels to the 7 days
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:pastSevenDate)
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom // Sets x-axis to be at the bottom
        
        lineChartView1.isUserInteractionEnabled = false // Stops user from interacting with trendline
        lineChartView1.leftAxis.axisMinimum = 0 // Sets the axis minimum
        lineChartView1.rightAxis.enabled = false// Removes right axis
        lineChartView1.xAxis.spaceMin = 0.5 // Sets padding of x-axis
        lineChartView1.xAxis.spaceMax = 0.5 // Sets padding of x-axis
        lineChartView1.xAxis.drawGridLinesEnabled = false // Removes gridlines
        lineChartView1.xAxis.labelFont = UIFont.systemFont(ofSize: 12) // Sets the axis font size
        lineChartView1.leftAxis.labelFont = UIFont.systemFont(ofSize: 12) // Sets the yaxis font size
        lineChartView1.legend.font = UIFont.systemFont(ofSize: 15) // Sets the legend font size
        
        // Sets the x axis labels to the 7 days
        lineChartView1.xAxis.valueFormatter = IndexAxisValueFormatter(values:pastSevenDate)
        lineChartView1.xAxis.labelPosition = XAxis.LabelPosition.bottom // Sets x-axis to be at the bottom
        
        for i in 0..<7 {
            // Add in all the data points to be plotted
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[6-i]))
            dataEntries.append(dataEntry)
            
            // Add in all the data points to be plotted
            let dataEntry1 = ChartDataEntry(x: Double(i), y: Double(values1[6-i]))
            dataEntries1.append(dataEntry1)
        }
        
        // Set the trendline data and legend labels
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Tilt Score")
        let lineChartDataSet1 = LineChartDataSet(entries: dataEntries1, label: "Bubble Pop Score")
        
        lineChartDataSet.colors = [tiltButtonColour] // Set the colour of the trendline
        lineChartDataSet.setCircleColor(tiltButtonColour) // Set the circle colour of the trendline
        lineChartDataSet.circleHoleColor = tiltButtonColour // Set the hole colour of the trendline
        lineChartDataSet.circleRadius = 4.0 // Set the circle radius of the trendline
        lineChartDataSet.lineWidth = 3.0 // Set the line width of the trendline
        lineChartDataSet.valueFont = (UIFont.systemFont(ofSize: 12)) // Sets the font size
        
        lineChartDataSet1.colors = [bubbleTextColour] // Set the colour of the trendline
        lineChartDataSet1.setCircleColor(bubbleTextColour) // Set the circle colour of the trendline
        lineChartDataSet1.circleHoleColor = bubbleTextColour // Set the hole colour of the trendline
        lineChartDataSet1.circleRadius = 4.0 // Set the circle radius of the trendline
        lineChartDataSet1.lineWidth = 3.0 // Set the line width of the trendline
        lineChartDataSet1.valueFont = (UIFont.systemFont(ofSize: 12)) // Sets the font size
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        let lineChartData1 = LineChartData(dataSet: lineChartDataSet1)
        
         // Set the respective trendline data
        lineChartView.data = lineChartData
        lineChartView1.data = lineChartData1
        
         // Set the trendline data to animate when loaded
        lineChartView.animate(yAxisDuration: 1.5, easingOption: .easeInSine)
        lineChartView1.animate(yAxisDuration: 1.5, easingOption: .easeInSine)
        
         // Add all trendlines to the screen
        dataScrollView.addSubview(lineChartView)
        dataScrollView.addSubview(lineChartView1)
        dataScrollView.contentSize.width = screenWidth * 3
    }
    
    /**
     Function that updates the labels on the daily data portion
     
     - Returns: None
     **/
    func setupDailyData() {
        dateLabel.text = "Date:  \(selectedDate)" // Set updated selected date
        medLabel.text = "Medication 1:  " + medicationName // Set updated medication name
        medLabel1.text = "Medication 2:  " + medicationName1 // Set updated medication name 2
        medLabel2.text = "Medication 3:  " + medicationName2 // Set updated medication name 3
        medLabel3.text = "Medication 4:  " + medicationName3 // Set updated medication name 4
        medLabel4.text = "Medication 5:  " + medicationName4 // Set updated medication name 5
        tiltGameScore.text = "Maximum TILT Score:  \(maxScoreSelectedDateOne)" // Set updated tilt score
        bubbleGameScore.text = "Maximum Bubble Pop Score:  \(maxScoreSelectedDateTwo)" //Set updated bubble pop score
        moodLabel.text = "Mood:  " + feeling // Set updated mood
    }
    
    
    /**
     Function that is triggered when the Sunday button is pressed
     
     - Returns: None
     **/
    @objc func sundayDateSelected(_ sender: Any) {
        let currentTimeDate = dateFormatter.string(from: Date())
        
        selectedDate = sundayDatewithMY
        updateInformation() // Update information to firebase
        highlightSelectedDate() // Highlight new selected date
        
        // Checks to see if you have tapped the current date twice
        // If you have selected the current date twice, have the mood popup display to allow changes to the mood
        if selectedDate == currentTimeDate && alreadyTappedTodaysDate == true {
            alreadyTappedTodaysDate = false
            popoverFeeling()
        }
        else if selectedDate == currentTimeDate {alreadyTappedTodaysDate = true}
        else { alreadyTappedTodaysDate = false }
    }
    
    
    /**
     Function that is triggered when the Monday button is pressed
     
     - Returns: None
     **/
    @objc func mondayDateSelected(_ sender: Any) {
        let currentTimeDate = dateFormatter.string(from: Date())
        
        selectedDate = mondayDatewithMY
        updateInformation() // Update information to firebase
        highlightSelectedDate() // Highlight new selected date
        
        // Checks to see if you have tapped the current date twice
        // If you have selected the current date twice, have the mood popup display to allow changes to the mood
        if selectedDate == currentTimeDate && alreadyTappedTodaysDate == true {
            alreadyTappedTodaysDate = false
            popoverFeeling()
        }
        else if selectedDate == currentTimeDate {alreadyTappedTodaysDate = true}
        else { alreadyTappedTodaysDate = false }
    }
    
    
    /**
     Function that is triggered when the Tuesday button is pressed
     
     - Returns: None
     **/
    @objc func tuesdayDateSelected(_ sender: Any) {
        let currentTimeDate = dateFormatter.string(from: Date())
        
        selectedDate = tuesdayDatewithMY
        updateInformation() // Update information to firebase
        highlightSelectedDate() // Highlight new selected date
        
        // Checks to see if you have tapped the current date twice
        // If you have selected the current date twice, have the mood popup display to allow changes to the mood
        if selectedDate == currentTimeDate && alreadyTappedTodaysDate == true {
            alreadyTappedTodaysDate = false
            popoverFeeling()
        }
        else if selectedDate == currentTimeDate {alreadyTappedTodaysDate = true}
        else { alreadyTappedTodaysDate = false }
    }
    
    
    /**
     Function that is triggered when the Wednesday button is pressed
     
     - Returns: None
     **/
    @objc func wednesdayDateSelected(_ sender: Any) {
        let currentTimeDate = dateFormatter.string(from: Date())
        
        selectedDate = wednesdayDatewithMY
        updateInformation() // Update information to firebase
        highlightSelectedDate() // Highlight new selected date
        
        // Checks to see if you have tapped the current date twice
        // If you have selected the current date twice, have the mood popup display to allow changes to the mood
        if selectedDate == currentTimeDate && alreadyTappedTodaysDate == true {
            alreadyTappedTodaysDate = false
            popoverFeeling()
        }
        else if selectedDate == currentTimeDate {alreadyTappedTodaysDate = true}
        else { alreadyTappedTodaysDate = false }
    }
    
    
    /**
     Function that is triggered when the Thursday button is pressed
     
     - Returns: None
     **/
    @objc func thursdayDateSelected(_ sender: Any) {
        let currentTimeDate = dateFormatter.string(from: Date())
        
        selectedDate = thursdayDatewithMY
        updateInformation() // Update information to firebase
        highlightSelectedDate() // Highlight new selected date
        
        // Checks to see if you have tapped the current date twice
        // If you have selected the current date twice, have the mood popup display to allow changes to the mood
        if selectedDate == currentTimeDate && alreadyTappedTodaysDate == true {
            alreadyTappedTodaysDate = false
            popoverFeeling()
        }
        else if selectedDate == currentTimeDate {alreadyTappedTodaysDate = true}
        else { alreadyTappedTodaysDate = false }
    }
    
    
    /**
     Function that is triggered when the Friday button is pressed
     
     - Returns: None
     **/
    @objc func fridayDateSelected(_ sender: Any) {
        let currentTimeDate = dateFormatter.string(from: Date())
        
        selectedDate = fridayDatewithMY
        updateInformation() // Update information to firebase
        highlightSelectedDate() // Highlight new selected date
        
        // Checks to see if you have tapped the current date twice
        // If you have selected the current date twice, have the mood popup display to allow changes to the mood
        if selectedDate == currentTimeDate && alreadyTappedTodaysDate == true {
            alreadyTappedTodaysDate = false
            popoverFeeling()
        }
        else if selectedDate == currentTimeDate {alreadyTappedTodaysDate = true}
        else { alreadyTappedTodaysDate = false }
    }
    
    
    /**
     Function that is triggered when the Saturday button is pressed
     
     - Returns: None
     **/
    @objc func saturdayDateSelected(_ sender: Any) {
        let currentTimeDate = dateFormatter.string(from: Date())
        
        selectedDate = saturdayDatewithMY
        updateInformation() // Update information to firebase
        highlightSelectedDate() // Highlight new selected date
        
        // Checks to see if you have tapped the current date twice
        // If you have selected the current date twice, have the mood popup display to allow changes to the mood
        if selectedDate == currentTimeDate && alreadyTappedTodaysDate == true {
            alreadyTappedTodaysDate = false
            popoverFeeling()
        }
        else if selectedDate == currentTimeDate {alreadyTappedTodaysDate = true}
        else { alreadyTappedTodaysDate = false }
    }
    
    
    /**
     Function that grabs information from firebase and updates the local information
     
     - Returns: None
     **/
    func updateInformation() {
        let db = Firestore.firestore()
        var selectedDateinDatetype = dateFormatter.date(from: selectedDate)
        
        // Grab information for the past seven days from the selected date
        for dayi in 0..<7 {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let tempSelectedDate = dateFormatter.string(from: selectedDateinDatetype!)
            
            // Call firebase to retrieve data
            db.collection("users").document(userid).collection("gaming_score").document(tempSelectedDate).getDocument { (document, error) in
                if error == nil {
                    if document != nil && document!.exists {
                        let documentData = document!.data()
                        
                        // Update values if there is data in firebase
                        values[dayi] = documentData!["Game_One_lastMaxScore"] as! Int
                        values1[dayi] = documentData!["Game_Two_lastMaxScore"] as! Int
                    }
                    else {
                        // If there is no data in firebase, set values to 0
                        values[dayi] = 0
                        values1[dayi] = 0
                    }
                }
                // Check to see that all the data has been retrieved from firebase
                self.checkDataStatus()
            }
            // Update new date to retrieve information for
            selectedDateinDatetype = selectedDateinDatetype! - 3600*24
        }
        
        // Call firebase to retrieve information about the mood and max score
        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    let DocumentData = document!.data()
                    
                    // If there is data in firebase, retrieve the data and store it locally
                    maxScoreSelectedDateOne = DocumentData!["Game_One_lastMaxScore"] as! Int
                    maxScoreSelectedDateTwo = DocumentData!["Game_Two_lastMaxScore"] as! Int
                    feeling = DocumentData!["feeling"] as! String
                }
                else {
                    // If no data exists in firebase, set the default values for mood and scores
                    maxScoreSelectedDateOne = 0
                    maxScoreSelectedDateTwo = 0
                    feeling = "N/A"
                }
            }
            // Update the trendline and daily data section
            self.setupDailyData()
        }
    }
    
    
    /**
     Helper function of updateInformation that allows us to check if we have successfully retrieved all the data
     
     - Returns: None
     **/
    func checkDataStatus() {
        // Checks to see if 7 data values have been retrieved
        loadedInfoTrendline += 1
        
        if loadedInfoTrendline == 7 {
            // If all data has been retrieved, update the trendline again to make sure we have the correct values
            loadedInfoTrendline = 0
            setupTrendline(currentDate: selectedDate)
        }
    }
    
    
    /**
     Function about the Tilt Button, will direct you to the Tilt page
     
     - Parameter sender: Button itself
     - Returns: No
     
     **/
    @objc func tiltButtonPressed(_ sender: Any) {
        let tiltUIViewController:TiltUIViewController = TiltUIViewController()
        tiltUIViewController.modalPresentationStyle = .fullScreen // Set the view style to be fullscreen
        self.present(tiltUIViewController, animated: true, completion: nil)
    }
    
    
    /**
     Function about the Bubble Pop Button, will direct you to the Bubble Pop  page
     
     - Parameter sender: Button itself
     - Returns: No
     
     **/
    @objc func bubblePopButtonPressed(_ sender: Any) {
        let bubblePopUIViewController:BubbleUIViewController = BubbleUIViewController()
        bubblePopUIViewController.modalPresentationStyle = .fullScreen // Set the view style to be fullscreen
        self.present(bubblePopUIViewController, animated: true, completion: nil)
    }
    
    
    /**
     Function to  change the scroll view to page control view
     
     - Parameter : Button itself
     - Returns: No
     
     **/
    func scrollViewDidEndDecelerating(_ DataScrollView: UIScrollView) {
        let page = DataScrollView.contentOffset.x/DataScrollView.frame.width // Set the page bounds
        pageControl.currentPage = Int(page) // Change the page control active page
    }
    
    
    /**
     Function that directs you to Login
     
     - Returns: None
     **/
    @objc func signOutTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
