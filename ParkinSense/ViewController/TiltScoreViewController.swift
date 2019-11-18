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
        label.text = "Score"
        label.textAlignment = .center
        label.font = tiltTitleFont
        label.textColor = tiltTextColour
        label.heightAnchor.constraint(equalToConstant: finalScoreStaticLabelHeight).isActive = true
        return label
    }()
    
    //Final score label
    let finalScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score"
        label.textAlignment = .center
        label.font = tiltFinalScoreFont
        label.textColor = tiltTextColour
        label.heightAnchor.constraint(equalToConstant: finalScoreLabelHeight).isActive = true
        return label
    }()
    
    //Replay button
    let replayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Replay", for: .normal)
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = tiltButtonColour
        button.addTarget(self, action: #selector(replayButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: replayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: replayButtonHeight).isActive = true
        return button
    }()
    
    //Quit button that brings you back to home view
    let finalQuitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Quit", for: .normal)
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = tiltButtonColour
        button.addTarget(self, action: #selector(quitButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: finalQuitButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: finalQuitButtonHeight).isActive = true
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
        
        finalScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        finalScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        finalScoreLabel.topAnchor.constraint(equalTo: finalScoreStaticLabel.topAnchor, constant: finalScoreStaticLabelHeight + 16.0).isActive = true
        
        replayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tiltReplayButtonButtonOffset).isActive = true
        replayButton.topAnchor.constraint(equalTo: finalScoreLabel.topAnchor, constant: finalScoreLabelHeight + 64.0).isActive = true
        
        finalQuitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tiltFinalQuitButtonOffset).isActive = true
        finalQuitButton.topAnchor.constraint(equalTo: replayButton.topAnchor, constant: replayButtonHeight + 24.0).isActive = true
        
        //Sets background colour of view
        view.backgroundColor = tiltBackgroundColour
        
        finalScoreLabel.text = String(tiltFinalScore)
        let db = Firestore.firestore()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentTimeDate = dateFormatter.string(from: Date())
        
        //Updates score on database
        if  tiltFinalScore > maxScoreToday {
            maxScoreToday = tiltFinalScore
        db.collection("users").document(userid).collection("gaming_score").document(currentTimeDate).setData(["date":thisTimeLoginDateStr, "Game_One_lastMaxScore":maxScoreToday])
            
            db.collection("users").document(userid).setData(["login_time": rightNow, "Username": username, "MedicationName": medicationName, "uid":userid, "Game_One_lastMaxScore":maxScoreToday])
            
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
    
}

