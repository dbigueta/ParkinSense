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

    
    @IBOutlet weak var DataScrollView: UIScrollView!
    
    @IBOutlet weak var PageControl: UIPageControl!
    
    @IBOutlet weak var GameOneButton: UIButton!
    
    @IBOutlet weak var GameTwoButton: UIButton!
    
    var Datalabeltext1: UILabel!
    
    var Datalabeltext2: UILabel!
    
    var Datalabeltext3: UILabel!
    
    var lineChartView: LineChartView!
    
    var ref: DatabaseReference?
    
    //var values = [gamedata1, gamedata2, gamedata3, gamedata4, gamedata5, gamedata6, gamedata7]
    
//    var dataEntries: [ChartDataEntry] = []
//
//    var dataEntry = ChartDataEntry(x: 0, y: 0)
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //userid = Auth.auth().currentUser!.uid
        
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
        var currentYear = Calendar.current.component(.year, from: Date()) //get the current Year

        var currentWeek = Calendar.current.component(.weekOfYear, from: Date()) //get the current week of the year

        var rightNow = Date() //get the current date and time
        
        
        @IBOutlet weak var weekdateLabel: UILabel!
        
        @IBOutlet weak var PrevWeek: UIButton!
        
        @IBOutlet weak var NextWeek: UIButton!
        
        
        @IBOutlet weak var SundayButton: UIButton!
        @IBOutlet weak var MondayButton: UIButton!
        @IBOutlet weak var TuesdayButton: UIButton!
        @IBOutlet weak var WednesdayButton: UIButton!
        @IBOutlet weak var ThursdayButton: UIButton!
        @IBOutlet weak var FridayButton: UIButton!
        @IBOutlet weak var SaturdayButton: UIButton!
        
    let db = Firestore.firestore() //use for data read and write in database for later function
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do the main page setup for buttons and label appearance after loading the view.
        setUp(newformattedtartcurrentweek: formattedStartCurrentWeek, newformattedendcurrentweek: formattedEndCurrentWeek) // call setUp function to setup the button view
        sevendaydate(currentdate: rightNow) // call sevendaydate function to get the Sunday to Saturday date, and set up the button title for every date button
        hightlightselectedDate()
        
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
                    //print(thistimeLogindatestr)
//                    //==================================================================
//                    print(selectedDate)
//                    var selectedDateinDatetype = dateFormatter.date(from: selectedDate)
//                    print(selectedDateinDatetype)
//
//                    for dayi in 0..<7{
//                        dateFormatter.dateFormat = "yyyy-MM-dd"
//                        let tempselecteddate = dateFormatter.string(from: selectedDateinDatetype!)
//                        print(tempselecteddate)
//                        self.db.collection("users").document(userid).collection("gaming_score").document(tempselecteddate).getDocument { (document, error) in
//                            if error == nil{
//                                if document != nil && document!.exists{
//                                    var maxScoreinSelected = 0
//                                    let DocumentData = document!.data()
//                                    maxScoreinSelected = DocumentData!["max_Game_Score"] as! Int
//                                    print("Max Score for today:  \(maxScoreinSelected)")
//                                    values[dayi] = maxScoreinSelected
//                                    print(values[dayi])
//                                }
//                                else{
//                                    print("Max Score for today:  0")
//                                    values[dayi] = 0
//                                    print(values[dayi])
//                                }
//                            }
//                        }
//
//                        selectedDateinDatetype = selectedDateinDatetype! - 3600*24
//                    }
//                    //====================================================================
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    @IBAction func NextWeekButton(_ sender: Any) {
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
        
            hightlightselectedDate()
        }
        
    /**
        Function for displaying prev week date by clicking the next week button
     
         - Parameters: Button itself
         - Returns: No
            
    **/
        
        @IBAction func PrevWeekButton(_ sender: Any) {
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
            
            hightlightselectedDate()
        }
        
    /**
        Function to  set up the calendar appearance
     
         - Parameter newformattedtartcurrentweek: String
         - Parameter newformattedendcurrentweek: String
         - Returns: No
            
    **/
        
        
        func setUp(newformattedtartcurrentweek: String, newformattedendcurrentweek: String)
        {
            weekdateLabel.text = "\(newformattedtartcurrentweek)" + " ~ " + "\(newformattedendcurrentweek)"
            
            
            //set up the button appearance for the following buttons
            Utilities.styleFilledDateButton(SundayButton)
            Utilities.styleFilledDateButton(MondayButton)
            Utilities.styleFilledDateButton(TuesdayButton)
            Utilities.styleFilledDateButton(WednesdayButton)
            Utilities.styleFilledDateButton(ThursdayButton)
            Utilities.styleFilledDateButton(FridayButton)
            Utilities.styleFilledDateButton(SaturdayButton)
            Utilities.styleFilledDateButton(GameOneButton)
            Utilities.styleFilledDateButton(GameTwoButton)
            
            //Utilities.styleFilledButton(NextWeek)
            //Utilities.styleFilledButton(PrevWeek)
            
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
            SundayButton.setTitle(SundayDate, for: .normal)
            MondayButton.setTitle(MondayDate, for: .normal)
            TuesdayButton.setTitle(TuesdayDate, for: .normal)
            WednesdayButton.setTitle(WednesdayDate, for: .normal)
            ThursdayButton.setTitle(ThursdayDate, for: .normal)
            FridayButton.setTitle(FridayDate, for: .normal)
            SaturdayButton.setTitle(SaturdayDate, for: .normal)
        }

    
    func hightlightselectedDate(){
        if selectedDate == sundayDatewithMY{Utilities.styleFilledDateButton(SundayButton)}
        if selectedDate == mondayDatewithMY{Utilities.styleFilledDateButton(MondayButton)}
        if selectedDate == tuesdayDatewithMY{Utilities.styleFilledDateButton(TuesdayButton)}
        if selectedDate == wednesdayDatewithMY{Utilities.styleFilledDateButton(WednesdayButton)}
        if selectedDate == thursdayDatewithMY{Utilities.styleFilledDateButton(ThursdayButton)}
        if selectedDate == fridayDatewithMY{Utilities.styleFilledDateButton(FridayButton)}
        if selectedDate == saturdayDatewithMY{Utilities.styleFilledDateButton(SaturdayButton)}
    }
    
    func setUpDailyDatainit(currentDate: String){
        //============================================================
        //Create the scroll view of the user's daily data
        //The first page will be the trendline of the last seven days (image for now)
        //the second page will be the daily data read from Firebase (text for now)
        
        //============================================================================================
        
        //let imagesArray = ["AppIcon", "personalimage"] //load the image for page control view setup
        
        // create the page for the page control
        self.PageControl.numberOfPages = 2
        
        
        //First page modified by create imageView
        let x1Pos = CGFloat(0)*self.view.bounds.size.width //get the x position of the view that for the first page content
        lineChartView = LineChartView(frame: CGRect(x: x1Pos, y: 0, width: self.view.frame.size.width, height: (self.DataScrollView.frame.size.height)))
        
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
        self.DataScrollView.addSubview(lineChartView)
        //====================================================================================
        
        
        //Daily date page scroll view
        let x2Pos = CGFloat(1)*self.view.bounds.size.width //get the x position of the view that for the second page content
        Datalabeltext1 = UILabel(frame: CGRect(x: x2Pos, y: 40, width: self.view.frame.size.width, height: self.DataScrollView.frame.size.height/4)) //set up the label frame
        Datalabeltext1.textAlignment = .center //place the label text in the center of the second page
        Datalabeltext1.text = "Medication Name:  " + medicationName
        self.DataScrollView.contentSize.width = self.view.frame.size.width*CGFloat(1+1) //set up the Scroll view content size
        self.DataScrollView.addSubview(Datalabeltext1) //put the label text into scrollView
        
        Datalabeltext2 = UILabel(frame: CGRect(x: x2Pos, y: 0, width: self.view.frame.size.width, height: self.DataScrollView.frame.size.height/4)) //set up the label frame
        Datalabeltext2.textAlignment = .center //place the label text in the center of the second page
        Datalabeltext2.text = "Date:  " + currentDate
        self.DataScrollView.contentSize.width = self.view.frame.size.width*CGFloat(1+1) //set up the Scroll view content size
        self.DataScrollView.addSubview(Datalabeltext2)
        
        Datalabeltext3 = UILabel(frame: CGRect(x: x2Pos, y: 80, width: self.view.frame.size.width, height: self.DataScrollView.frame.size.height/4)) //set up the label frame
        Datalabeltext3.textAlignment = .center //place the label text in the center of the second page
        Datalabeltext3.text = "Max Score for today:  \(maxScoreToday)"
        self.DataScrollView.contentSize.width = self.view.frame.size.width*CGFloat(1+1) //set up the Scroll view content size
        self.DataScrollView.addSubview(Datalabeltext3)
        self.DataScrollView.delegate = self
        
        //===========================================================
    }
    
    
    @IBAction func SundayDateSelected(_ sender: Any) {
//        print(SundayButton.titleLabel!)
//        selectedDate = SundayButton.titleLabel!.text!
//        print(selectedDate)

        print(sundayDatewithMY)
        selectedDate = sundayDatewithMY
        
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
        //db.collection("users").document(userid).collection("game_score").document("2019-11-08")
        
        //var maxScoreinSelected = 0
        
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
        Utilities.styleFilledDateButton(SundayButton)
    }
    
    @IBAction func MondayDateSelected(_ sender: Any) {
        //print(MondayButton.titleLabel!)
        //selectedDate = MondayButton.titleLabel!.text!
        //print(selectedDate)
         print(values)
        print(mondayDatewithMY)
        selectedDate = mondayDatewithMY
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
        
        Utilities.styleFilledDateButton(MondayButton)
    }
    
    @IBAction func TuesdayDateSelected(_ sender: Any) {
//        print(TuesdayButton.titleLabel!)
//        selectedDate = TuesdayButton.titleLabel!.text!
//        print(selectedDate)
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
        
        Utilities.styleFilledDateButton(TuesdayButton)
    }
    
    @IBAction func WednesdayDateSelected(_ sender: Any) {
//        print(WednesdayButton.titleLabel!)
//        selectedDate = WednesdayButton.titleLabel!.text!
//        print(selectedDate)
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
        
        Utilities.styleFilledDateButton(WednesdayButton)
    }
    
    @IBAction func ThursdayDateSelected(_ sender: Any) {
//        print(ThursdayButton.titleLabel!)
//        selectedDate = ThursdayButton.titleLabel!.text!
//        print(selectedDate)
         print(values)
        print(thursdayDatewithMY)
        selectedDate = thursdayDatewithMY
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
        Utilities.styleFilledDateButton(ThursdayButton)
    }
    
    @IBAction func FridayDateSelected(_ sender: Any) {
//        print(FridayButton.titleLabel!)
//        selectedDate = FridayButton.titleLabel!.text!
//        print(selectedDate)
         print(values)
        print(fridayDatewithMY)
        selectedDate = fridayDatewithMY
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
//        db.collection("users").document(userid).getDocument { (document, error) in
//            if error == nil{
//                if document != nil && document!.exists{
//                    let DocumentData = document!.data()
//                    maxScoreinSelected = DocumentData!["max_Game_Score"] as! Int
//                }
//            }
//        }
        
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
        Utilities.styleFilledDateButton(FridayButton)
    }
    
    @IBAction func SaturadyDateSelected(_ sender: Any) {
//        print(SaturdayButton.titleLabel!)
//        selectedDate = SaturdayButton.titleLabel!.text!
//        print(selectedDate)
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
        
        Utilities.styleFilledDateButton(SaturdayButton)
    }
    
    
    /**
        Function about the Game One Button, will direct you to the Game One page
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    
    @IBAction func GameOneButtnPressed(_ sender: Any) {
    }
    
    /**
        Function about the Game Two Button, will direct you to the Game Two page
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    
    @IBAction func GameTwoButtonPressed(_ sender: Any) {
    }
    
    /**
        Function to  change the scroll view to page control view
     
         - Parameter : Button itself
         - Returns: No
            
    **/
    
    func scrollViewDidEndDecelerating(_ DataScrollView: UIScrollView) {
        let page = DataScrollView.contentOffset.x/DataScrollView.frame.width
        
        PageControl.currentPage = Int(page)
    }
}
