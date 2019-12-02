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
//      - Refactored code to programmatically code UI elements
//      - Added comments to clarify code
//      - Added scene to main storyboard
//
//  Known Bugs:
//      - Dismissing view shows a glimpse of previous views
//
//-----------------------------------------------------------------

import UIKit
import AVFoundation
import FirebaseDatabase
import FirebaseAuth
import Firebase

class TiltScoreViewController: UIViewController {
    
    //Final score Title label
    let finalScoreStaticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score" // Set label text
        label.textAlignment = .center // Set label text alignment
        label.font = tiltTitleFont // Set label text font
        label.textColor = tiltTextColour // Set label text font colour
        label.heightAnchor.constraint(equalToConstant: finalScoreStaticLabelHeight).isActive = true // Set label height
        return label
    }()
    
    //Final score label
    let finalScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score" // Set label text
        label.textAlignment = .center // Set label text alignment
        label.font = tiltFinalScoreFont // Set label text font
        label.textColor = tiltTextColour // Set label text font colour
        label.heightAnchor.constraint(equalToConstant: finalScoreLabelHeight).isActive = true // Set label height
        return label
    }()
    
    //Replay button
    let replayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("REPLAY", for: .normal) // Set button label text
        button.setTitleColor(tiltTextColour, for: .normal) // Set button label text font colour
        button.layer.cornerRadius = 25 // Make button to have rounded corners
        button.backgroundColor = tiltButtonColour // Set button background colour
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium) // Set button label text font
        button.addTarget(self, action: #selector(replayButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: replayButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: replayButtonHeight).isActive = true // Set button height
        return button
    }()
    
    //Quit button that brings you back to home view
    let finalQuitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("QUIT", for: .normal) // Set button label text
        button.setTitleColor(tiltTextColour, for: .normal) // Set button label text font colour
        button.layer.cornerRadius = 25 // Make button to have rounded corners
        button.backgroundColor = tiltButtonColour // Set button background colour
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium) // Set button label text font
        button.addTarget(self, action: #selector(quitButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: finalQuitButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: finalQuitButtonHeight).isActive = true // Set button height
        return button
    }()
    
    
    
    /**
     Function runs when this current view has been loaded. Updates the score based on the score of the previous game.
     
     - Returns: None.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adds all labels and buttons to the view
        view.addSubview(finalScoreStaticLabel)
        view.addSubview(finalScoreLabel)
        view.addSubview(replayButton)
        view.addSubview(finalQuitButton)
        
        
        //Sets up all the constraints of the labels and buttons
        finalScoreStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        finalScoreStaticLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        finalScoreStaticLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 128.0).isActive = true
        
         // Set tilt final score constraints to allow for multiple device configurations
        finalScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        finalScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        finalScoreLabel.topAnchor.constraint(equalTo: finalScoreStaticLabel.topAnchor, constant: finalScoreStaticLabelHeight + 16.0).isActive = true
        
         // Set tilt replay button constraints to allow for multiple device configurations
        replayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tiltReplayButtonButtonOffset).isActive = true
        replayButton.topAnchor.constraint(equalTo: finalScoreLabel.topAnchor, constant: finalScoreLabelHeight + 64.0).isActive = true
        
         // Set tilt quit button constraints to allow for multiple device configurations
        finalQuitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tiltFinalQuitButtonOffset).isActive = true
        finalQuitButton.topAnchor.constraint(equalTo: replayButton.topAnchor, constant: replayButtonHeight + 24.0).isActive = true
        
        //Sets background colour of view
        view.backgroundColor = tiltBackgroundColour
        
        finalScoreLabel.text = String(tiltFinalScore)
        let db = Firestore.firestore()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentTimeDate = dateFormatter.string(from: Date())
        
        //Updates score on database
        if  tiltFinalScore > maxScoreTodayOne {
            maxScoreTodayOne = tiltFinalScore
           
            // Update the database
            db.collection("users").document(userid).collection("gaming_score").document(currentTimeDate).setData(["date":thisTimeLoginDateStr, "Game_One_lastMaxScore":maxScoreTodayOne, "Game_Two_lastMaxScore":maxScoreTodayTwo, "feeling": feeling])
         
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
                       "feeling": feeling
                   ])
        }
    }
    
    
    /**
     Transitions back to the main menu of Tilt
     
     - Returns: None
     **/
    @objc func replayButtonPressed(_ sender: Any){
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    /**
     Quits the game Tilt
     
     - Returns: None
     **/
    @objc func quitButtonPressed(_ sender: Any){
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("The Tilt Score View has been removed from memory")
    }
    
    
}

