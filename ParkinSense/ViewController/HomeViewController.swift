//-----------------------------------------------------------------
//  File: HomeViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng
//
//  Description:
//
//  Changes:
//      - Added the swipe and page control
//      - Modified the gaming icon
//
//  Known Bugs:
//      - need to put the trendline and data text label
//      - constraints need to fix to flexiable
//
//-----------------------------------------------------------------

import UIKit
import Charts
import FirebaseDatabase
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController, UIScrollViewDelegate{
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()

        view.axis = .vertical
        view.spacing = 10

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dataScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var Datalabeltext1: UILabel!

    var Datalabeltext2: UILabel!

    var Datalabeltext3: UILabel!

    var lineChartView: LineChartView!
    
    let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()

    let calendarView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: calendarViewHeight).isActive = true
        view.backgroundColor = .blue
        return view
    }()
    
    let weekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Weekly Calendar"
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        return label
    }()
    
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
    
    let weekDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date Range"
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: screenWidth/3).isActive = true
        label.heightAnchor.constraint(equalToConstant: weekButtonHeight).isActive = true
        return label
    }()

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
    
    let sundayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        //button.layer.borderColor = UIColor(red:0.75, green:0.85, blue:0.84, alpha:1.0).cgColor
        return button
    }()

    let mondayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()
    
    let tuesdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()
    
    let wednesdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()
    
    let thursdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()
    
    let fridayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()
    
    let saturdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeDayButtonBorderWidth
        button.layer.cornerRadius = 5
        button.widthAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeDayButtonWidth).isActive = true
        return button
    }()

    let gameView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        //view.backgroundColor = .green
        return view
    }()
    
    let gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Games"
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        return label
    }()
    
    let tiltButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeGameButtonBorderWidth
        button.layer.cornerRadius = 5
        button.setTitle("Tilt", for: .normal)
        button.addTarget(self, action: #selector(tiltButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true
        return button
    }()
    
    let bubblePopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.borderWidth = homeGameButtonBorderWidth
        button.layer.cornerRadius = 5
        button.setTitle("Bubble Pop", for: .normal)
        button.addTarget(self, action: #selector(bubblePopButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: homeGameButtonWidth).isActive = true
        return button
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
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
        scrollViewContainer.addArrangedSubview(dataScrollView)
        scrollViewContainer.addArrangedSubview(calendarView)
        scrollViewContainer.addArrangedSubview(gameView)

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        weekLabel.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 16.0).isActive = true
        weekLabel.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: -16.0).isActive = true
        weekLabel.topAnchor.constraint(equalTo: calendarView.topAnchor, constant: 16.0).isActive = true
        
        prevWeek.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 8.0).isActive = true
        prevWeek.topAnchor.constraint(equalTo: weekLabel.topAnchor, constant: headerHeight + 16.0).isActive = true
        
        weekDateLabel.leadingAnchor.constraint(equalTo: prevWeek.leadingAnchor, constant: screenWidth/3).isActive = true
        weekDateLabel.topAnchor.constraint(equalTo: weekLabel.topAnchor, constant: headerHeight + 16.0).isActive = true
        
        nextWeek.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: -8.0).isActive = true
        nextWeek.topAnchor.constraint(equalTo: weekLabel.topAnchor, constant: headerHeight + 16.0).isActive = true
        
        sundayButton.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 3).isActive = true
        sundayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 16.0).isActive = true

        mondayButton.leadingAnchor.constraint(equalTo: sundayButton.leadingAnchor, constant: homeDayButtonWidth + 4).isActive = true
        mondayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 16.0).isActive = true
        
        tuesdayButton.leadingAnchor.constraint(equalTo: mondayButton.leadingAnchor, constant: homeDayButtonWidth + 4).isActive = true
        tuesdayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 16.0).isActive = true

        wednesdayButton.leadingAnchor.constraint(equalTo: tuesdayButton.leadingAnchor, constant: homeDayButtonWidth + 4).isActive = true
        wednesdayButton.topAnchor.constraint(equalTo: weekDateLabel.topAnchor, constant: weekButtonHeight + 16.0).isActive = true

        thursdayButton.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 0).isActive = true
        thursdayButton.topAnchor.constraint(equalTo: sundayButton.topAnchor, constant: homeDayButtonWidth + 16.0).isActive = true

        fridayButton.leadingAnchor.constraint(equalTo: thursdayButton.leadingAnchor, constant: homeDayButtonWidth).isActive = true
        fridayButton.topAnchor.constraint(equalTo: sundayButton.topAnchor, constant: homeDayButtonWidth + 16.0).isActive = true

        saturdayButton.leadingAnchor.constraint(equalTo: fridayButton.leadingAnchor, constant: homeDayButtonWidth).isActive = true
        saturdayButton.topAnchor.constraint(equalTo: sundayButton.topAnchor, constant: homeDayButtonWidth + 16.0).isActive = true
        
        gameLabel.leadingAnchor.constraint(equalTo: gameView.leadingAnchor, constant: 16.0).isActive = true
        gameLabel.trailingAnchor.constraint(equalTo: gameView.trailingAnchor, constant: -16.0).isActive = true
        gameLabel.topAnchor.constraint(equalTo: gameView.topAnchor, constant: 16.0).isActive = true
        
        tiltButton.leadingAnchor.constraint(equalTo: gameView.leadingAnchor, constant: 0).isActive = true
        tiltButton.topAnchor.constraint(equalTo: gameLabel.topAnchor, constant: headerHeight + 16.0).isActive = true

        bubblePopButton.leadingAnchor.constraint(equalTo: tiltButton.leadingAnchor, constant: homeGameButtonWidth).isActive = true
        bubblePopButton.topAnchor.constraint(equalTo: gameLabel.topAnchor, constant: headerHeight + 16.0).isActive = true
        
        self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
        setupRest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
//
//    /////////////////////////////////////////////////////////////////////////////

//


    var ref: DatabaseReference?

    var currentYear = Calendar.current.component(.year, from: Date()) //get the current Year

    var currentWeek = Calendar.current.component(.weekOfYear, from: Date()) //get the current week of the year

    var rightNow = Date() //get the current date and time

    let db = Firestore.firestore() //use for data read and write in database for later function
    
    func setupRest() {

        // Do the main page setup for buttons and label appearance after loading the view.
        setUp(newformattedtartcurrentweek: formattedStartCurrentWeek, newformattedendcurrentweek: formattedEndCurrentWeek) // call setUp function to setup the button view
        sevendaydate(currentdate: rightNow) // call sevendaydate function to get the Sunday to Saturday date, and set up the button title for every date button
        //hightlightselectedDate()

        //=============================================================
        //Get the current user information from Firebase and check the condition to update the login time and the popup

        //ref = Database.database().reference()
        userid = Auth.auth().currentUser!.uid //get the current user id from Firebase
        //Update the login time for the current user
        //need to check the user account exist before access the data
        db.collection("users").document(userid).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    let DocumentData = document!.data() //get all the corresponding data in Firebase and store it in DocumentData
                    //print (DocumentData!)
                    username = DocumentData!["Username"] as! String
                    medicationName = DocumentData!["MedicationName"] as! String
                    maxScoreToday = DocumentData!["Game_One_lastMaxScore"] as! Int

                    let lasttimeLogin = DocumentData!["login_time"] as! Timestamp // get the last time login time for temp in Timestamp type
                    //print(lasttimeLogin.dateValue())
                    let lasttimeLogindate = lasttimeLogin.dateValue() // get the current login time
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    lastTimeLoginDateStr = dateFormatter.string(from: lasttimeLogindate) // format the timestamp type to string
                    //print(lasttimeLogindatestr)
                    thisTimeLoginDateStr = dateFormatter.string(from: Date()) // format the timestamp type to string
                    //====================================================================
                    self.setUpDailyDatainit(currentDate: thisTimeLoginDateStr) //set up the page controll view

                    //Check if the user is the first time login, if so, the pops up will be activated
                    if lastTimeLoginDateStr != thisTimeLoginDateStr{
                        //print("in popover")
                        self.popover()

                        //initialize the game score for first login in everyday
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let currentTimeDate = dateFormatter.string(from: Date())
                        self.db.collection("users").document(userid).collection("gaming_score").document(currentTimeDate).setData(["date":thisTimeLoginDateStr, "Game_One_lastMaxScore":maxScoreToday])

                    }
                }
            }
        }
    }


    /**
     Function to set up the pops up

     - Parameters: No
     - Returns: No

     - TODO: Set the mood, not display for medicine

     **/

    func popover(){
        let alert = UIAlertController(title: "Reminder", message: "Did you take your medicine today?", preferredStyle: .alert) //set up the alert information
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil)) //set up the OK button to exist
        db.collection("users").document(userid).setData(["login_time": rightNow, "Username": username, "MedicationName": medicationName, "uid":userid, "Game_One_lastMaxScore":0]) //Update the user last login time in Firebase for next time login checking
        self.present(alert,animated: true) //active the present of pop up
    }

    /**
     Function for displaying next week date by clicking the next week button

     - Parameters: Button itself
     - Returns: No

     **/

    @objc func nextWeekButtonPressed(_ sender: Any) {
        let nextweek = rightNow + 3600*24*7 // get one of the date in next week
        rightNow = nextweek
        sevendaydate(currentdate: rightNow) //update the new seven days' date

        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
        currentWeek += 1 //record the current week of the year
        if currentWeek == 53 {
            currentWeek = 1
            currentYear += 1
        }
        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek) // redraw the current week's appearance buttons

        //hightlightselectedDate()
    }

    /**
     Function for displaying prev week date by clicking the next week button

     - Parameters: Button itself
     - Returns: No

     **/

    @objc func prevWeekButtonPressed(_ sender: Any) {
        let nextweek = rightNow - 3600*24*7 // get one of the date in next week
        rightNow = nextweek
        sevendaydate(currentdate: rightNow) //update the new seven days' date

        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week

        currentWeek -= 1 //record the current week of the year
        if currentWeek == 0 {
            currentWeek = 52
            currentYear -= 1
        }
        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek) // redraw the current week's appearance buttons

        //hightlightselectedDate()
    }

    /**
     Function to  set up the calendar appearance

     - Parameter newformattedtartcurrentweek: String
     - Parameter newformattedendcurrentweek: String
     - Returns: No

     **/


    func setUp(newformattedtartcurrentweek: String, newformattedendcurrentweek: String)
    {
        weekDateLabel.text = "\(newformattedtartcurrentweek)" + " ~ " + "\(newformattedendcurrentweek)"

    }

    /**
     Function to  update  date in calender in constant

     - Parameter currentdate: Date
     - Returns: No

     **/

    func sevendaydate(currentdate: Date){

        //get the corresponding date of the days
        let SundayDate = sundayDate(startCurrentWeek: currentdate)
        let MondayDate = mondayDate(startCurrentWeek: currentdate)
        let TuesdayDate = tuesdayDate(startCurrentWeek: currentdate)
        let WednesdayDate = wednesdayDate(startCurrentWeek: currentdate)
        let ThursdayDate = thursdayDate(startCurrentWeek: currentdate)
        let FridayDate = fridayDate(startCurrentWeek: currentdate)
        let SaturdayDate = saturdayDate(startCurrentWeek: currentdate)
        //set title of the buttons text
        sundayButton.setTitle(SundayDate, for: .normal)
        mondayButton.setTitle(MondayDate, for: .normal)
        tuesdayButton.setTitle(TuesdayDate, for: .normal)
        wednesdayButton.setTitle(WednesdayDate, for: .normal)
        thursdayButton.setTitle(ThursdayDate, for: .normal)
        fridayButton.setTitle(FridayDate, for: .normal)
        saturdayButton.setTitle(SaturdayDate, for: .normal)
    }


//    func hightlightselectedDate(){
//        if selectedDate == sundayDatewithMY{Utilities.styleFilledDateButton(SundayButton)}
//        if selectedDate == mondayDatewithMY{Utilities.styleFilledDateButton(MondayButton)}
//        if selectedDate == tuesdayDatewithMY{Utilities.styleFilledDateButton(TuesdayButton)}
//        if selectedDate == wednesdayDatewithMY{Utilities.styleFilledDateButton(WednesdayButton)}
//        if selectedDate == thursdayDatewithMY{Utilities.styleFilledDateButton(ThursdayButton)}
//        if selectedDate == fridayDatewithMY{Utilities.styleFilledDateButton(FridayButton)}
//        if selectedDate == saturdayDatewithMY{Utilities.styleFilledDateButton(SaturdayButton)}
//    }

    func setUpDailyDatainit(currentDate: String){
        //============================================================
        //Create the scroll view of the user's daily data
        //The first page will be the trendline of the last seven days (image for now)
        //the second page will be the daily data read from Firebase (text for now)

        //============================================================================================

        // create the page for the page control
        self.pageControl.numberOfPages = 2

        //First page modified by create imageView
        let x1Pos = CGFloat(0)*self.view.bounds.size.width //get the x position of the view that for the first page content
        lineChartView = LineChartView(frame: CGRect(x: x1Pos, y: 0, width: self.view.frame.size.width, height: (self.dataScrollView.frame.size.height)))

        updategamescore()
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<7 {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[6-i]))
            dataEntries.append(dataEntry)
            //print("dataEntry: \(dataEntry)")
        }
        print("dataEntries: \(dataEntries)")
        print("values: \(values)")

        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Click the date twice to see last seven days data")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        self.dataScrollView.addSubview(lineChartView)
        //====================================================================================


        //Daily date page scroll view
        let x2Pos = CGFloat(1)*self.view.bounds.size.width //get the x position of the view that for the second page content
        Datalabeltext1 = UILabel(frame: CGRect(x: x2Pos, y: 40, width: self.view.frame.size.width, height: self.dataScrollView.frame.size.height/4)) //set up the label frame
        Datalabeltext1.textAlignment = .center //place the label text in the center of the second page
        Datalabeltext1.text = "Medication Name:  " + medicationName
        self.dataScrollView.contentSize.width = self.view.frame.size.width*CGFloat(1+1) //set up the Scroll view content size
        self.dataScrollView.addSubview(Datalabeltext1) //put the label text into scrollView

        Datalabeltext2 = UILabel(frame: CGRect(x: x2Pos, y: 0, width: self.view.frame.size.width, height: self.dataScrollView.frame.size.height/4)) //set up the label frame
        Datalabeltext2.textAlignment = .center //place the label text in the center of the second page
        Datalabeltext2.text = "Date:  " + currentDate
        self.dataScrollView.contentSize.width = self.view.frame.size.width*CGFloat(1+1) //set up the Scroll view content size
        self.dataScrollView.addSubview(Datalabeltext2)

        Datalabeltext3 = UILabel(frame: CGRect(x: x2Pos, y: 80, width: self.view.frame.size.width, height: self.dataScrollView.frame.size.height/4)) //set up the label frame
        Datalabeltext3.textAlignment = .center //place the label text in the center of the second page
        Datalabeltext3.text = "Max Score for today:  \(maxScoreToday)"
        self.dataScrollView.contentSize.width = self.view.frame.size.width*CGFloat(1+1) //set up the Scroll view content size
        self.dataScrollView.addSubview(Datalabeltext3)
        self.dataScrollView.delegate = self

        //===========================================================
    }


    @IBAction func SundayDateSelected(_ sender: Any) {
        print(sundayDatewithMY)
        selectedDate = sundayDatewithMY

        //========================================================================
        updategamescore()
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<7 {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[6-i]))
            dataEntries.append(dataEntry)
        }
        print("values: \(values)")
        print(dataEntries)
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Click the date twice to see last seven days data")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData

        //=========================================================================
        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
        //setUpDailyData(currentDate: selectedDate)
        Datalabeltext2.text = "Date:  \(selectedDate)"

        db.collection("users").document(userid).collection("game_score").document(selectedDate).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    var maxScoreinSelected = 0
                    let DocumentData = document!.data()
                    maxScoreinSelected = DocumentData!["Game_One_lastMaxScore"] as! Int
                    self.Datalabeltext3.text = "Max Score for today:  \(maxScoreinSelected)"
                }
                else{
                    self.Datalabeltext3.text = "Max Score for today:  0"
                }
            }
        }
        Utilities.styleFilledDateButton(sundayButton)
    }

    @IBAction func MondayDateSelected(_ sender: Any) {
        print(values)
        print(mondayDatewithMY)
        selectedDate = mondayDatewithMY
        //========================================================================
        updategamescore()
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<7 {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[6-i]))
            dataEntries.append(dataEntry)
        }
        print("values: \(values)")
        print(dataEntries)
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Click the date twice to see last seven days data")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData

        //=========================================================================

        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
        //setUpDailyData(currentDate: selectedDate)
        Datalabeltext2.text = "Date:  \(selectedDate)"

        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    var maxScoreinSelected = 0
                    let DocumentData = document!.data()
                    maxScoreinSelected = DocumentData!["Game_One_lastMaxScore"] as! Int
                    print(maxScoreinSelected)
                    self.Datalabeltext3.text = "Max Score for today:  \(maxScoreinSelected)"
                }
                else{
                    self.Datalabeltext3.text = "Max Score for today:  0"
                }
            }
        }

        Utilities.styleFilledDateButton(mondayButton)
    }

    @IBAction func TuesdayDateSelected(_ sender: Any) {
        print(values)
        print(tuesdayDatewithMY)
        selectedDate = tuesdayDatewithMY
        //========================================================================
        updategamescore()
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<7 {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[6-i]))
            dataEntries.append(dataEntry)
            //print("dataEntry: \(dataEntry)")
        }
        print("values: \(values)")
        print(dataEntries)
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Click the date twice to see last seven days data")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData

        //=========================================================================

        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
        //setUpDailyData(currentDate: selectedDate)
        Datalabeltext2.text = "Date:  \(selectedDate)"

        //var maxScoreinSelected = 0

        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    var maxScoreinSelected = 0
                    let DocumentData = document!.data()
                    maxScoreinSelected = DocumentData!["Game_One_lastMaxScore"] as! Int
                    print(maxScoreinSelected)
                    self.Datalabeltext3.text = "Max Score for today:  \(maxScoreinSelected)"
                }
                else{
                    self.Datalabeltext3.text = "Max Score for today:  0"
                }
            }
        }

        Utilities.styleFilledDateButton(tuesdayButton)
    }

    @IBAction func WednesdayDateSelected(_ sender: Any) {
        print(values)
        print(wednesdayDatewithMY)
        selectedDate = wednesdayDatewithMY
        //========================================================================
        updategamescore()
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<7 {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[6-i]))
            dataEntries.append(dataEntry)
            //print("dataEntry: \(dataEntry)")
        }
        print("values: \(values)")
        print(dataEntries)
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Click the date twice to see last seven days data")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData

        //=========================================================================

        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
        //setUpDailyData(currentDate: selectedDate)
        Datalabeltext2.text = "Date:  \(selectedDate)"

        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    var maxScoreinSelected = 0
                    let DocumentData = document!.data()
                    maxScoreinSelected = DocumentData!["Game_One_lastMaxScore"] as! Int
                    print(maxScoreinSelected)
                    self.Datalabeltext3.text = "Max Score for today:  \(maxScoreinSelected)"
                }
                else{
                    self.Datalabeltext3.text = "Max Score for today:  0"
                }
            }
        }

        Utilities.styleFilledDateButton(wednesdayButton)
    }

    @IBAction func ThursdayDateSelected(_ sender: Any) {
        print(values)
        print(thursdayDatewithMY)
        selectedDate = thursdayDatewithMY
        //========================================================================
        updategamescore()
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<7 {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[6-i]))
            dataEntries.append(dataEntry)

        }
        print("values: \(values)")
        print(dataEntries)
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Click the date twice to see last seven days data")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData

        //=========================================================================

        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)
        //setUpDailyData(currentDate: selectedDate)
        Datalabeltext2.text = "Date:  \(selectedDate)"


        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    var maxScoreinSelected = 0
                    let DocumentData = document!.data()
                    maxScoreinSelected = DocumentData!["Game_One_lastMaxScore"] as! Int
                    print(maxScoreinSelected)
                    self.Datalabeltext3.text = "Max Score for today:  \(maxScoreinSelected)"
                }
                else{
                    self.Datalabeltext3.text = "Max Score for today:  0"
                }
            }

        }
        Utilities.styleFilledDateButton(thursdayButton)
    }

    @IBAction func FridayDateSelected(_ sender: Any) {
        print(values)
        print(fridayDatewithMY)
        selectedDate = fridayDatewithMY
        //========================================================================
        updategamescore()
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<7 {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[6-i]))
            dataEntries.append(dataEntry)

        }
        print("values: \(values)")
        print(dataEntries)
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Click the date twice to see last seven days data")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData

        //=========================================================================

        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)

        Datalabeltext2.text = "Date:  \(selectedDate)"

        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    var maxScoreinSelected = 0
                    let DocumentData = document!.data()
                    maxScoreinSelected = DocumentData!["Game_One_lastMaxScore"] as! Int
                    print(maxScoreinSelected)
                    self.Datalabeltext3.text = "Max Score for today:  \(maxScoreinSelected)"
                }
                else{
                    self.Datalabeltext3.text = "Max Score for today:  0"
                }
            }
        }
        Utilities.styleFilledDateButton(fridayButton)
    }

    @IBAction func SaturadyDateSelected(_ sender: Any) {
        print(values)
        print(saturdayDatewithMY)
        selectedDate = saturdayDatewithMY
        //========================================================================
        updategamescore()
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<7 {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[6-i]))
            dataEntries.append(dataEntry)
            //print("dataEntry: \(dataEntry)")
        }
        print("values: \(values)")
        print(dataEntries)
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Click the date twice to see last seven days data")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData

        //=========================================================================

        let newformattedtartcurrentweek = newStartCurrentWeek(updateNow: rightNow) //get the first date of the choosen week
        let newformattedendcurrentweek = newEndCurrentWeek(updateNow: rightNow) //get the end date of the choosen week
        setUp(newformattedtartcurrentweek: newformattedtartcurrentweek, newformattedendcurrentweek: newformattedendcurrentweek)

        Datalabeltext2.text = "Date:  \(selectedDate)"

        db.collection("users").document(userid).collection("gaming_score").document(selectedDate).getDocument { (document, error) in
            if error == nil{
                if document != nil && document!.exists{
                    var maxScoreinSelected = 0
                    let DocumentData = document!.data()
                    maxScoreinSelected = DocumentData!["Game_One_lastMaxScore"] as! Int
                    print(maxScoreinSelected)
                    self.Datalabeltext3.text = "Max Score for today:  \(maxScoreinSelected)"
                }
                else{
                    self.Datalabeltext3.text = "Max Score for today:  0"
                }
            }
        }

        Utilities.styleFilledDateButton(saturdayButton)
    }


    /**
     Function about the Game One Button, will direct you to the Game One page

     - Parameter sender: Button itself

     - Returns: No

     **/

    @objc func tiltButtonPressed(_ sender: Any) {
        let tiltUIViewController:TiltUIViewController = TiltUIViewController()

        self.present(tiltUIViewController, animated: true, completion: nil)
    }

    /**
     Function about the Game Two Button, will direct you to the Game Two page

     - Parameter sender: Button itself

     - Returns: No

     **/

    @objc func bubblePopButtonPressed(_ sender: Any) {
        let bubblePopViewController:BubbleViewController = BubbleViewController()

        self.present(bubblePopViewController, animated: true, completion: nil)
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
}
