//-----------------------------------------------------------------
//  File: TiltScoreViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Hamlet Jiang Su
//
//  Description: View controller that displays once TILT has reached a count of 0. Shows the score and options to
//                  quit or replay.
//
//  Changes:
//      - Added comments to clarify code
//      - Added scene to main storyboard
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import UIKit
import AVFoundation
import FirebaseDatabase
import FirebaseAuth
import Firebase

class TiltScoreViewController: UIViewController {
    
    var fScore: Int = 0
    @IBOutlet weak var finalScore: UILabel!
    
    /**
     Function runs when this current view has been loaded. Updates the score based on the score of the previous game.
     
     - Returns: None.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red:0.77, green:0.93, blue:0.87, alpha:1.0)
        
        finalScore.text = String(fScore)
        let db = Firestore.firestore()
        //db.collection("users").document(userid).setData(["login_time": rightNow, "Username": username, "MedicationName": medicationName, "uid":userid, "gaming_score": fScore])
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentTimeDate = dateFormatter.string(from: Date())
        
        //print(maxScoreToday)
        if  fScore > maxScoreToday {
        
            
            maxScoreToday = fScore
            
        db.collection("users").document(userid).collection("gaming_score").document(currentTimeDate).setData(["date":thisTimeLoginDateStr, "Game_One_lastMaxScore":maxScoreToday])
            
            db.collection("users").document(userid).setData(["login_time": rightNow, "Username": username, "MedicationName": medicationName, "uid":userid, "Game_One_lastMaxScore":maxScoreToday])
        
            
        }
    }
    
}

