//-----------------------------------------------------------------
//  File: HomeViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng
//
//  Changes:
//      - list change here
//
//  Known Bugs:
//      - list known bugs here
//
//-----------------------------------------------------------------

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController, UIScrollViewDelegate{

    
    @IBOutlet weak var DataScrollView: UIScrollView!
    
    @IBOutlet weak var PageControl: UIPageControl!
    
    @IBOutlet weak var GameOneButton: UIButton!
    
    @IBOutlet weak var GameTwoButton: UIButton!
    
    var ref: DatabaseReference?
    
    
    
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
    
    let imagesArray = ["AppIcon", "personalimage"] //load the image for page control view setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //============================================================
        //Create the scroll view of the user's daily data
        //The first page will be the trendline of the last seven days (image for now)
        //the second page will be the daily data read from Firebase (text for now)
        
        // create the page for the page control
        PageControl.numberOfPages = imagesArray.count
        
        //First page modified by create imageView
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill //set the imageViec's contentMode
        imageView.image = UIImage(named: imagesArray[0]) //read the image from the imageArray and
        let x1Pos = CGFloat(0)*self.view.bounds.size.width //get the x position of the view that for the first page content
        imageView.frame = CGRect(x: x1Pos, y: 0, width: view.frame.size.width, height: DataScrollView.frame.size.height) //set up the imageView's frame

        DataScrollView.addSubview(imageView) //put the imageView into scrollView
        
        let x2Pos = CGFloat(1)*self.view.bounds.size.width //get the x position of the view that for the second page content
        let Datalabeltext = UILabel(frame: CGRect(x: x2Pos, y: 0, width: view.frame.size.width, height: DataScrollView.frame.size.height)) //set up the label frame
        Datalabeltext.textAlignment = .center //place the label text in the center of the second page
        Datalabeltext.text = "I'm a test label"
        DataScrollView.contentSize.width = view.frame.size.width*CGFloat(1+1) //set up the Scroll view content size
        DataScrollView.addSubview(Datalabeltext) //put the label text into scrollView
        DataScrollView.delegate = self
        
        //===========================================================
        // Do the main page setup for buttons and label appearance after loading the view.
        setUp(newformattedtartcurrentweek: formattedStartCurrentWeek, newformattedendcurrentweek: formattedEndCurrentWeek) // call setUp function to setup the button view
        sevendaydate(currentdate: rightNow) // call sevendaydate function to get the Sunday to Saturday date, and set up the button title for every date button
        
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
                    let lasttimeLogin = DocumentData!["login_time"] as! Timestamp // get the last time login time for temp in Timestamp type
                    //print(lasttimeLogin.dateValue())
                    let lasttimeLogindate = lasttimeLogin.dateValue() // get the current login time
                    dateFormatter.dateFormat = "yyyy/MM/dd"
                    lastTimeLoginDateStr = dateFormatter.string(from: lasttimeLogindate) // format the timestamp type to string
                    //print(lasttimeLogindatestr)
                    thisTimeLoginDateStr = dateFormatter.string(from: Date()) // format the timestamp type to string
                    //print(thistimeLogindatestr)
                    
                    //Check if the user is the first time login, if so, the pops up will be activated
                    if lastTimeLoginDateStr != thisTimeLoginDateStr{
                         //print("in popover")
                        self.popover()
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
        db.collection("users").document(userid).setData(["login_time": rightNow, "Username": username, "MedicationName": medicationName, "uid":userid]) //Update the user last login time in Firebase for next time login checking
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
