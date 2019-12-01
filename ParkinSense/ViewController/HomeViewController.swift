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
    var currentYear = Calendar.current.component(.year, from: Date()) //get the current Year
    var currentWeek = Calendar.current.component(.weekOfYear, from: Date()) //get the current week of the year
    var rightNow = Date() //get the current date and time
    let db = Firestore.firestore() //use for data read and write in database for later function
    
    //Scroll view to allow scrolling of content
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //Container that keeps all the scrollable content
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Progress view that contains the progress label
    let signOutView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.heightAnchor.constraint(equalToConstant: signOutViewHeight).isActive = true
        return view
    }()
    
    // Sign Out Button
    let signOutButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button)
        button.setTitle("Sign Out", for: .normal)
        button.addTarget(self, action: #selector(signOutTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    //Progress view that contains the progress label
    let progressView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: progressViewHeight).isActive = true
        return view
    }()
    
    //Progress UI label
    let progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Weekly Progress"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: headerFontSize, weight: .medium)
        label.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        return label
    }()
    
    //Data scroll view that contains the trendline and the day information
    let dataScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.heightAnchor.constraint(equalToConstant: dataScrollViewHeight).isActive = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    //variables related to the day information in the trendline
    var Datalabeltext1: UILabel!
    var Datalabeltext2: UILabel!
    var Datalabeltext3: UILabel!
    var Datalabeltext4: UILabel!
    
    var lineChartView: LineChartView!
    var lineChartView1: LineChartView!
    
    
    //Allows for a consistent switch between trendline and day information
    let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.pageIndicatorTintColor = .gray
        page.currentPageIndicatorTintColor = .black
        page.numberOfPages = 3
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()
    
    // Calendar view that displays the days of the week, and the next/prev buttons
    let calendarView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: calendarViewHeight).isActive = true
        return view
    }()
    
    //Week header UI label
    let weekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Weekly Calendar"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: headerFontSize, weight: .medium)
        label.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        return label
    }()
    
    //Prev week button
    let prevWeek: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("< Prev", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(buttonTextColour, for: .normal)
        button.addTarget(self, action: #selector(prevWeekButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: screenWidth/3).isActive = true
        button.heightAnchor.constraint(equalToConstant: weekButtonHeight).isActive = true
        return button
    }()
    
    //Date range UI Label
    let weekDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date Range"
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: screenWidth/3).isActive = true
        label.heightAnchor.constraint(equalToConstant: weekButtonHeight).isActive = true
        return label
    }()
    
    //next week button
    let nextWeek: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next >", for: .normal)
        button.contentHorizontalAlignment = .right
        button.setTitleColor(buttonTextColour, for: .normal)
        button.addTarget(self, action: #selector(nextWeekButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: screenWidth/3).isActive = true
        button.heightAnchor.constraint(equalToConstant: weekButtonHeight).isActive = true
        return button
    }()
    
    //Sunday button
    let sundayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.backgroundColor = buttonColour
        button.addTarget(self, action: #selector(sundayDateSelected(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        //button.layer.borderColor = UIColor(red:0.75, green:0.85, blue:0.84, alpha:1.0).cgColor
        return button
    }()
    
    //Monday button
    let mondayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.backgroundColor = buttonColour
        button.addTarget(self, action: #selector(mondayDateSelected(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()
    
    //Tuesday button
    let tuesdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.backgroundColor = buttonColour
        button.addTarget(self, action: #selector(tuesdayDateSelected(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()
    
    //Wednesday button
    let wednesdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.backgroundColor = buttonColour
        button.addTarget(self, action: #selector(wednesdayDateSelected(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()
    
    //Thursday button
    let thursdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.backgroundColor = buttonColour
        button.addTarget(self, action: #selector(thursdayDateSelected(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()
    
    //Friday button
    let fridayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.backgroundColor = buttonColour
        button.addTarget(self, action: #selector(fridayDateSelected(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()
    
    //Saturday button
    let saturdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.backgroundColor = buttonColour
        button.addTarget(self, action: #selector(saturdayDateSelected(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()
    
    //Game view that contains the two buttons to initiate the games
    let gameView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: gameViewHeight).isActive = true
        return view
    }()
    
    //Game header UI label
    let gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Games"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: headerFontSize, weight: .medium)
        label.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        return label
    }()
    
    //Tilt button
    let tiltButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeGameButtonBorderWidth
        button.layer.cornerRadius = 5
        button.backgroundColor = buttonColour
        button.setTitle("Tilt", for: .normal)
        button.addTarget(self, action: #selector(tiltButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true
        return button
    }()
    
    //Bubble Pop button
    let bubblePopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeGameButtonBorderWidth
        button.layer.cornerRadius = 5
        button.backgroundColor = buttonColour
        button.setTitle("Bubble Pop", for: .normal)
        button.addTarget(self, action: #selector(bubblePopButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true
        return button
    }()
    
    // MARK: Class Functions
    
    
    /**
     Function that adds all UI elements to the view and sets up all constraints for each UI element
     
     - Returns: None
     **/
    override func loadView(){
        super.loadView()
        
        //Add labels, buttons, and views to its respective locations
        signOutView.addSubview(signOutButton)
        
        progressView.addSubview(progressLabel)
        
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
        
        gameView.addSubview(gameLabel)
        gameView.addSubview(tiltButton)
        gameView.addSubview(bubblePopButton)
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(signOutView)
        scrollViewContainer.addArrangedSubview(progressView)
        scrollViewContainer.addArrangedSubview(dataScrollView)
        scrollViewContainer.addArrangedSubview(calendarView)
        scrollViewContainer.addArrangedSubview(gameView)
        
        //Setup constraints for all views, labels, and buttons
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        signOutView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        signOutView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        signOutView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        
        signOutButton.topAnchor.constraint(equalTo: signOutView.topAnchor, constant: 16.0).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        signOutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        signOutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        progressLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 16.0).isActive = true
        progressLabel.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: -16.0).isActive = true
        progressLabel.topAnchor.constraint(equalTo: progressView.topAnchor).isActive = true
        
        pageControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.0).isActive = true
        pageControl.topAnchor.constraint(equalTo: dataScrollView.topAnchor, constant: dataScrollViewHeight - 4.0).isActive = true
        
        weekLabel.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 16.0).isActive = true
        weekLabel.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: -16.0).isActive = true
        weekLabel.topAnchor.constraint(equalTo: calendarView.topAnchor, constant: 24.0).isActive = true
        
        prevWeek.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 8.0).isActive = true
        prevWeek.topAnchor.constraint(equalTo: weekLabel.topAnchor, constant: headerHeight).isActive = true
        
        weekDateLabel.leadingAnchor.constraint(equalTo: prevWeek.leadingAnchor, constant: screenWidth/3).isActive = true
        weekDateLabel.topAnchor.constraint(equalTo: weekLabel.topAnchor, constant: headerHeight).isActive = true
        
        nextWeek.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: -8.0).isActive = true
        nextWeek.topAnchor.constraint(equalTo: weekLabel.topAnchor, constant: headerHeight).isActive = true
        
        sundayButton.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: offsetTopWeekButtons).isActive = true
        sundayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 24.0).isActive = true
        
        mondayButton.leadingAnchor.constraint(equalTo: sundayButton.leadingAnchor, constant: homeDayButtonWidth + offsetTopWeekButtons).isActive = true
        mondayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 24.0).isActive = true
        
        tuesdayButton.leadingAnchor.constraint(equalTo: mondayButton.leadingAnchor, constant: homeDayButtonWidth + offsetTopWeekButtons).isActive = true
        tuesdayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 24.0).isActive = true
        
        wednesdayButton.leadingAnchor.constraint(equalTo: tuesdayButton.leadingAnchor, constant: homeDayButtonWidth + offsetTopWeekButtons).isActive = true
        wednesdayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 24.0).isActive = true
        
        thursdayButton.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: offsetBottomWeekButtons).isActive = true
        thursdayButton.topAnchor.constraint(equalTo: sundayButton.topAnchor, constant: homeDayButtonWidth + 16.0).isActive = true
        
        fridayButton.leadingAnchor.constraint(equalTo: thursdayButton.leadingAnchor, constant: homeDayButtonWidth + offsetTopWeekButtons).isActive = true
        fridayButton.topAnchor.constraint(equalTo: sundayButton.topAnchor, constant: homeDayButtonWidth + 16.0).isActive = true
        
        saturdayButton.leadingAnchor.constraint(equalTo: fridayButton.leadingAnchor, constant: homeDayButtonWidth + offsetTopWeekButtons).isActive = true
        saturdayButton.topAnchor.constraint(equalTo: sundayButton.topAnchor, constant: homeDayButtonWidth + 16.0).isActive = true
        
        gameLabel.leadingAnchor.constraint(equalTo: gameView.leadingAnchor, constant: 16.0).isActive = true
        gameLabel.trailingAnchor.constraint(equalTo: gameView.trailingAnchor, constant: -16.0).isActive = true
        gameLabel.topAnchor.constraint(equalTo: gameView.topAnchor).isActive = true
        
        tiltButton.leadingAnchor.constraint(equalTo: gameView.leadingAnchor, constant: offsetGameButtons).isActive = true
        tiltButton.topAnchor.constraint(equalTo: gameLabel.topAnchor, constant: headerHeight + 16.0).isActive = true
        
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
                    maxScoreTodayOne = DocumentData!["Game_One_lastMaxScore"] as! Int
                    maxScoreTodayTwo = DocumentData!["Game_Two_lastMaxScore"] as! Int
                    
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
                    
                    self.updategamescore()
                    // Set up the page control view
                    //self.setUpDailyDatainit(currentDate: thisTimeLoginDateStr)
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
        let currentTimeDate = dateFormatter.string(from: Date())
        
        var medicineTaken = false
        var mood = ""
        
        // Performs medication alert only if there was medication inputted
        if haveMedication == true {
            // Create a new alert controller to display alerts
            let alert = UIAlertController(title: "Medicine Reminder", message: "Did you take your medicine today?", preferredStyle: .alert)
            
            // Add alert option
            alert.addAction(UIAlertAction(title: "Yes", style: .default) {Void in
                medicineTaken = true
                mood = self.popoverFeeling()
            })
            
            // Add alert option
            alert.addAction(UIAlertAction(title: "No", style: .default) {Void in
                medicineTaken = false
                mood = self.popoverFeeling()
            })
            
            self.present(alert,animated: true)
        }
        else {
            mood = popoverFeeling()
        }
        
        // Updates the Firebase database
        self.db.collection("users").document(userid).collection("gaming_score").document(currentTimeDate).setData([
            "date":thisTimeLoginDateStr,
            "Game_One_lastMaxScore":0,
            "Game_Two_lastMaxScore":0,
            "feeling": mood
        ]);
        
        // Updates the Firebase database
        self.db.collection("users").document(userid).setData([
            "login_time": self.rightNow,
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
            "Game_One_lastMaxScore": 0,
            "Game_Two_lastMaxScore": 0,
            "feeling": mood
        ])
    }
    
    
    /**
     Function that sets up the daily pop up notification for mood
     
     - Returns: String containing selected mood
     **/
    func popoverFeeling() -> String{
        var mood = ""
        
        // Create a new alert controller to display alerts
        let alert = UIAlertController(title: "Daily Mood", message: "What is your current mood?", preferredStyle: .alert)
        
        // Add alert options for each mood option
        alert.addAction(UIAlertAction(title: "Happy", style: .default) {Void in mood = "Happy" })
        alert.addAction(UIAlertAction(title: "Excited", style: .default) {Void in mood = "Excited" })
        alert.addAction(UIAlertAction(title: "Calm", style: .default) {Void in mood = "Calm" })
        alert.addAction(UIAlertAction(title: "Anxious", style: .default) {Void in mood = "Anxious" })
        alert.addAction(UIAlertAction(title: "Sad", style: .default) {Void in mood = "Sad" })
        alert.addAction(UIAlertAction(title: "Angry", style: .default) {Void in mood = "Angry" })
        
        self.present(alert,animated: true)
        
        return mood
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
     Function to det week range on calendar
     
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
        sundayButton.backgroundColor = buttonColour
        mondayButton.backgroundColor = buttonColour
        tuesdayButton.backgroundColor = buttonColour
        wednesdayButton.backgroundColor = buttonColour
        thursdayButton.backgroundColor = buttonColour
        fridayButton.backgroundColor = buttonColour
        saturdayButton.backgroundColor = buttonColour
        
        // Sets the background of the current selected date
        if selectedDate == sundayDatewithMY{
            sundayButton.backgroundColor = selectedDayBackgroundColour
        }
        if selectedDate == mondayDatewithMY{
            mondayButton.backgroundColor = selectedDayBackgroundColour
        }
        if selectedDate == tuesdayDatewithMY{
            tuesdayButton.backgroundColor = selectedDayBackgroundColour
        }
        if selectedDate == wednesdayDatewithMY{
            wednesdayButton.backgroundColor = selectedDayBackgroundColour
        }
        if selectedDate == thursdayDatewithMY{
            thursdayButton.backgroundColor = selectedDayBackgroundColour
        }
        if selectedDate == fridayDatewithMY{
            fridayButton.backgroundColor = selectedDayBackgroundColour
        }
        if selectedDate == saturdayDatewithMY{
            saturdayButton.backgroundColor = selectedDayBackgroundColour
        }
    }
    
    
    /**
     Function that sets up the trendline and daily data information
     
     - Parameter currentdate: String
     - Returns: None
     **/
    func setupTrendline(currentDate: String){
        
        lineChartView?.removeFromSuperview()
        lineChartView1?.removeFromSuperview()
        
        let x1Pos = CGFloat(0) * screenWidth
        let x3Pos = CGFloat(1) * screenWidth

        var dataEntries: [ChartDataEntry] = []
        var dataEntries1: [ChartDataEntry] = []
        
        lineChartView = LineChartView(frame: CGRect(x: x1Pos, y: 0, width: screenWidth, height: dataScrollViewHeight))
        lineChartView1 = LineChartView(frame: CGRect(x: x3Pos, y: 0, width: screenWidth, height: dataScrollViewHeight))
        
        selectedDateinDatetype = dateFormatter.date(from: selectedDate)
        pastSevenDatefunc(currentSelectedDate: selectedDateinDatetype!)
        
        lineChartView.isUserInteractionEnabled = false
        lineChartView.leftAxis.axisMinimum = 0
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.spaceMin = 0.5
        lineChartView.xAxis.spaceMax = 0.5
        lineChartView.xAxis.drawGridLinesEnabled = false
        
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:pastSevenDate)
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        lineChartView1.isUserInteractionEnabled = false
        lineChartView1.leftAxis.axisMinimum = 0
        lineChartView1.rightAxis.enabled = false
        lineChartView1.xAxis.spaceMin = 0.5
        lineChartView1.xAxis.spaceMax = 0.5
        lineChartView1.xAxis.drawGridLinesEnabled = false
    
        lineChartView1.xAxis.valueFormatter = IndexAxisValueFormatter(values:pastSevenDate)
        lineChartView1.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        for i in 0..<7 {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[6-i]))
            dataEntries.append(dataEntry)
            
            let dataEntry1 = ChartDataEntry(x: Double(i), y: Double(values1[6-i]))
            dataEntries1.append(dataEntry1)
        }
        
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Tilt Score")
        let lineChartDataSet1 = LineChartDataSet(entries: dataEntries1, label: "Bubble Pop Score")
        
        lineChartDataSet.colors = [UIColor(red:0.69, green:0.75, blue:0.84, alpha:1.0)]
        lineChartDataSet.setCircleColor(UIColor(red:0.69, green:0.75, blue:0.84, alpha:1.0))
        lineChartDataSet.circleHoleColor = UIColor(red:0.69, green:0.75, blue:0.84, alpha:1.0)
        lineChartDataSet.circleRadius = 4.0
        
        lineChartDataSet1.colors = [UIColor(red:0.69, green:0.75, blue:0.84, alpha:1.0)]
        lineChartDataSet1.setCircleColor(UIColor(red:0.69, green:0.75, blue:0.84, alpha:1.0))
        lineChartDataSet1.circleHoleColor = UIColor(red:0.69, green:0.75, blue:0.84, alpha:1.0)
        lineChartDataSet1.circleRadius = 4.0
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        let lineChartData1 = LineChartData(dataSet: lineChartDataSet1)
        
        lineChartView.data = lineChartData
        lineChartView1.data = lineChartData1
        
        lineChartView.animate(yAxisDuration: 1.5, easingOption: .easeInSine)
        lineChartView1.animate(yAxisDuration: 1.5, easingOption: .easeInSine)
        
        dataScrollView.addSubview(lineChartView)
        dataScrollView.addSubview(lineChartView1)
        dataScrollView.contentSize.width = screenWidth * 3
    }
    
    
    func setupDailyData() {
        
//                let x2Pos = CGFloat(2) * screenWidth
//              //Daily date page scroll viewlet x2Pos = CGFloat(2)*self.view.bounds.size.width //get the x position of the view that for the second page content
//              Datalabeltext1 = UILabel(frame: CGRect(x: x2Pos, y: 40, width: self.view.frame.size.width, height: self.dataScrollView.frame.size.height/4)) //set up the label frame
//              Datalabeltext1.textAlignment = .center //place the label text in the center of the second page
//              Datalabeltext1.text = "Medication Name:  " + medicationName
//              self.dataScrollView.contentSize.width = self.view.frame.size.width*CGFloat(1+2) //set up the Scroll view content size
//              self.dataScrollView.addSubview(Datalabeltext1) //put the label text into scrollView
//
//              Datalabeltext2 = UILabel(frame: CGRect(x: x2Pos, y: 0, width: self.view.frame.size.width, height: self.dataScrollView.frame.size.height/4)) //set up the label frame
//              Datalabeltext2.textAlignment = .center //place the label text in the center of the second page
//              Datalabeltext2.text = "Date:  " + currentDate
//              self.dataScrollView.contentSize.width = self.view.frame.size.width*CGFloat(1+2) //set up the Scroll view content size
//              self.dataScrollView.addSubview(Datalabeltext2)
//
//              Datalabeltext3 = UILabel(frame: CGRect(x: x2Pos, y: 80, width: self.view.frame.size.width, height: self.dataScrollView.frame.size.height/4)) //set up the label frame
//              Datalabeltext3.textAlignment = .center //place the label text in the center of the second page
//              Datalabeltext3.text = "Max Score for TILT today:  \(maxScoreTodayOne)"
//              self.dataScrollView.contentSize.width = self.view.frame.size.width*CGFloat(1+2) //set up the Scroll view content size
//              self.dataScrollView.addSubview(Datalabeltext3)
//              self.dataScrollView.delegate = self
//
//              Datalabeltext4 = UILabel(frame: CGRect(x: x2Pos, y: 120, width: self.view.frame.size.width, height: self.dataScrollView.frame.size.height/4)) //set up the label frame
//              Datalabeltext4.textAlignment = .center //place the label text in the center of the second page
//              Datalabeltext4.text = "Max Score for Bubble Pop today:  \(maxScoreTodayTwo)"
//              self.dataScrollView.contentSize.width = self.view.frame.size.width*CGFloat(1+2) //set up the Scroll view content size
//              self.dataScrollView.addSubview(Datalabeltext4)
//              self.dataScrollView.delegate = self
    }
    
    
    @objc func sundayDateSelected(_ sender: Any) {
        selectedDate = sundayDatewithMY
        updategamescore()
        
//        //=========================================================================
//        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
//        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
//        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
//        //setUpDailyData(currentDate: selectedDate)
//        Datalabeltext2.text = "Date:  \(selectedDate)"
//
//        db.collection("users").document(userid).collection("game_score").document(selectedDate).getDocument { (document, error) in
//            if error == nil{
//                if document != nil && document!.exists{
//                    var maxScoreinSelectedOne = 0
//                    let DocumentData = document!.data()
//                    maxScoreinSelectedOne = DocumentData!["Game_One_lastMaxScore"] as! Int
//                    self.Datalabeltext3.text = "Max Score for TILT today:  \(maxScoreinSelectedOne)"
//
//                    var maxScoreinSelectedTwo = 0
//                    maxScoreinSelectedTwo = DocumentData!["Game_Two_lastMaxScore"] as! Int
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  \(maxScoreinSelectedTwo)"
//
//                }
//                else{
//                    self.Datalabeltext3.text = "Max Score for TILT today:  0"
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  0"
//                }
//            }
//        }
//
        highlightSelectedDate()
    }
    
    @objc func mondayDateSelected(_ sender: Any) {
        selectedDate = mondayDatewithMY
        updategamescore()

        
//        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
//        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
//        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
//        Datalabeltext2.text = "Date:  \(selectedDate)"
//
//        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
//            if error == nil{
//                if document != nil && document!.exists{
//                    var maxScoreinSelectedOne = 0
//                    let DocumentData = document!.data()
//                    maxScoreinSelectedOne = DocumentData!["Game_One_lastMaxScore"] as! Int
//                    print(maxScoreinSelectedOne)
//                    self.Datalabeltext3.text = "Max Score for TILT today:  \(maxScoreinSelectedOne)"
//
//                    var maxScoreinSelectedTwo = 0
//                    maxScoreinSelectedTwo = DocumentData!["Game_Two_lastMaxScore"] as! Int
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  \(maxScoreinSelectedTwo)"
//                }
//                else{
//                    self.Datalabeltext3.text = "Max Score for TILT today:  0"
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  0"
//                }
//            }
//        }
        
        highlightSelectedDate()
    }
    
    @objc func tuesdayDateSelected(_ sender: Any) {
        selectedDate = tuesdayDatewithMY
        updategamescore()
//
//        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
//        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
//        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
//        //setUpDailyData(currentDate: selectedDate)
//        Datalabeltext2.text = "Date:  \(selectedDate)"
//
//        //var maxScoreinSelected = 0
//
//        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
//            if error == nil{
//                if document != nil && document!.exists{
//                    var maxScoreinSelectedOne = 0
//                    let DocumentData = document!.data()
//                    maxScoreinSelectedOne = DocumentData!["Game_One_lastMaxScore"] as! Int
//                    print(maxScoreinSelectedOne)
//                    self.Datalabeltext3.text = "Max Score for TILT today:  \(maxScoreinSelectedOne)"
//
//                    var maxScoreinSelectedTwo = 0
//                    maxScoreinSelectedTwo = DocumentData!["Game_Two_lastMaxScore"] as! Int
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  \(maxScoreinSelectedTwo)"
//                }
//                else{
//                    self.Datalabeltext3.text = "Max Score for TILT today:  0"
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  0"
//                }
//            }
//        }
        
        highlightSelectedDate()
    }
    
    @objc func wednesdayDateSelected(_ sender: Any) {
        selectedDate = wednesdayDatewithMY
        updategamescore()
        
//        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
//        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
//        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
//        //setUpDailyData(currentDate: selectedDate)
//        Datalabeltext2.text = "Date:  \(selectedDate)"
//
//        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
//            if error == nil{
//                if document != nil && document!.exists{
//                    var maxScoreinSelectedOne = 0
//                    let DocumentData = document!.data()
//                    maxScoreinSelectedOne = DocumentData!["Game_One_lastMaxScore"] as! Int
//                    print(maxScoreinSelectedOne)
//                    self.Datalabeltext3.text = "Max Score for TILT today:  \(maxScoreinSelectedOne)"
//
//                    var maxScoreinSelectedTwo = 0
//                    maxScoreinSelectedTwo = DocumentData!["Game_Two_lastMaxScore"] as! Int
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  \(maxScoreinSelectedTwo)"
//                }
//                else{
//                    self.Datalabeltext3.text = "Max Score for TILT today:  0"
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  0"
//                }
//            }
//        }
        
        highlightSelectedDate()
    }
    
    @objc func thursdayDateSelected(_ sender: Any) {
        selectedDate = thursdayDatewithMY
        updategamescore()

        
//        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
//        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
//        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
//        //setUpDailyData(currentDate: selectedDate)
//        Datalabeltext2.text = "Date:  \(selectedDate)"
//
//
//        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
//            if error == nil{
//                if document != nil && document!.exists{
//                    var maxScoreinSelectedOne = 0
//                    let DocumentData = document!.data()
//                    maxScoreinSelectedOne = DocumentData!["Game_One_lastMaxScore"] as! Int
//                    print(maxScoreinSelectedOne)
//                    self.Datalabeltext3.text = "Max Score for TILT today:  \(maxScoreinSelectedOne)"
//
//                    var maxScoreinSelectedTwo = 0
//                    maxScoreinSelectedTwo = DocumentData!["Game_Two_lastMaxScore"] as! Int
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  \(maxScoreinSelectedTwo)"
//                }
//                else{
//                    self.Datalabeltext3.text = "Max Score for TILT today:  0"
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  0"
//                }
//            }
//
//        }
        highlightSelectedDate()
    }
    
    @objc func fridayDateSelected(_ sender: Any) {
        selectedDate = fridayDatewithMY
        updategamescore()

//        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
//        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
//        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
//
//        Datalabeltext2.text = "Date:  \(selectedDate)"
//
//        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
//            if error == nil{
//                if document != nil && document!.exists{
//                    var maxScoreinSelectedOne = 0
//                    let DocumentData = document!.data()
//                    maxScoreinSelectedOne = DocumentData!["Game_One_lastMaxScore"] as! Int
//                    print(maxScoreinSelectedOne)
//                    self.Datalabeltext3.text = "Max Score for TILT today:  \(maxScoreinSelectedOne)"
//
//                    var maxScoreinSelectedTwo = 0
//                    maxScoreinSelectedTwo = DocumentData!["Game_Two_lastMaxScore"] as! Int
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  \(maxScoreinSelectedTwo)"
//                }
//                else{
//                    self.Datalabeltext3.text = "Max Score for TILT today:  0"
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  0"
//                }
//            }
//        }
        highlightSelectedDate()
    }
    
    @objc func saturdayDateSelected(_ sender: Any) {
        selectedDate = saturdayDatewithMY
        updategamescore()

//
//        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
//        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
//        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
//
//        Datalabeltext2.text = "Date:  \(selectedDate)"
//
//        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
//            if error == nil{
//                if document != nil && document!.exists{
//                    var maxScoreinSelectedOne = 0
//                    let DocumentData = document!.data()
//                    maxScoreinSelectedOne = DocumentData!["Game_One_lastMaxScore"] as! Int
//                    print(maxScoreinSelectedOne)
//                    self.Datalabeltext3.text = "Max Score for TILT today:  \(maxScoreinSelectedOne)"
//
//                    var maxScoreinSelectedTwo = 0
//                    maxScoreinSelectedTwo = DocumentData!["Game_Two_lastMaxScore"] as! Int
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  \(maxScoreinSelectedTwo)"
//                }
//                else{
//                    self.Datalabeltext3.text = "Max Score for TILT today:  0"
//                    self.Datalabeltext4.text = "Max Score for Bubble Pop today:  0"
//                }
//            }
//        }
//
        highlightSelectedDate()
    }
    

    func updategamescore() {
        let db = Firestore.firestore()
        var selectedDateinDatetype = dateFormatter.date(from: selectedDate)
        
        for dayi in 0..<7{
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let tempselecteddate = dateFormatter.string(from: selectedDateinDatetype!)
            db.collection("users").document(userid).collection("gaming_score").document(tempselecteddate).getDocument { (document, error) in
                if error == nil {
                    if document != nil && document!.exists{
                        var maxScoreinSelected = 0
                        var maxScoreinSelectedTwo = 0
                        let DocumentData = document!.data()
                        
                        maxScoreinSelected = DocumentData!["Game_One_lastMaxScore"] as! Int
                        maxScoreinSelectedTwo = DocumentData!["Game_Two_lastMaxScore"] as! Int

                        values[dayi] = maxScoreinSelected
                        values1[dayi] = maxScoreinSelectedTwo
                    }
                    else{
                        values[dayi] = 0
                        values1[dayi] = 0
                    }
                }
                self.checkDataStatus()
            }
            selectedDateinDatetype = selectedDateinDatetype! - 3600*24
        }
    }
    
    func checkDataStatus() {
        loadedInfoTrendline += 1
        if loadedInfoTrendline == 7 {
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
        self.present(tiltUIViewController, animated: true, completion: nil)
    }
    
    
    /**
     Function about the Bubble Pop Button, will direct you to the Bubble Pop  page
     
     - Parameter sender: Button itself
     - Returns: No
     
     **/
    @objc func bubblePopButtonPressed(_ sender: Any) {
        let bubblePopUIViewController:BubbleUIViewController = BubbleUIViewController()
        self.present(bubblePopUIViewController, animated: true, completion: nil)
    }
    
    
    /**
     Function to  change the scroll view to page control view
     
     - Parameter : Button itself
     - Returns: No
     
     **/
    func scrollViewDidEndDecelerating(_ DataScrollView: UIScrollView) {
        let page = DataScrollView.contentOffset.x/DataScrollView.frame.width
        pageControl.currentPage = Int(page)
    }

    /**
     Function that directs you to Login
     
     - Returns: None
     **/
    @objc func signOutTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
