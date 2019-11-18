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
    
    let finalScoreStaticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score"
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: finalScoreStaticLabelHeight).isActive = true
        return label
    }()
    
    let finalScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score"
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: finalScoreLabelHeight).isActive = true
        return label
    }()
    
    let replayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Replay", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(replayButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: replayButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: replayButtonHeight).isActive = true
        return button
    }()
    
    let finalQuitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Quit", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(quitButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: finalQuitButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: finalQuitButtonHeight).isActive = true
        return button
    }()
    
    
    var fScore: Int = 0
    //@IBOutlet weak var finalScore: UILabel!
    
    /**
     Function runs when this current view has been loaded. Updates the score based on the score of the previous game.
     
     - Returns: None.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(finalScoreStaticLabel)
        view.addSubview(finalScoreLabel)
        view.addSubview(replayButton)
        view.addSubview(finalQuitButton)
        
        
        finalScoreStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        finalScoreStaticLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        finalScoreStaticLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        finalScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        finalScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        finalScoreLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        replayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        replayButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        replayButton.topAnchor.constraint(equalTo: finalScoreLabel.topAnchor, constant: finalScoreLabelHeight + 16).isActive = true
        
        finalQuitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        finalQuitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        finalQuitButton.topAnchor.constraint(equalTo: replayButton.topAnchor, constant: replayButtonHeight + 16).isActive = true
        
        
        
        
        
        
        view.backgroundColor = UIColor(red:0.77, green:0.93, blue:0.87, alpha:1.0)
        
        finalScoreLabel.text = String(fScore)
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
    
    @objc func replayButtonPressed(_ sender: Any){
        
    }
    
    @objc func quitButtonPressed(_ sender: Any){
        
    }
    
}

