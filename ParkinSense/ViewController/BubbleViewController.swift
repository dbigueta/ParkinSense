//-----------------------------------------------------------------
//  File: BubbleViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Hamlet Jiang Su
//
//  Description: Main TILT view controller that presents the countdown and bubble game scenes
//
//  Changes:
//      - Added comments to clarify code
//      - Added viewDidDisappear() and prepare() to transtition over to the Bubble Score View
//      - Added functions that help set up the countdown scene and transition to it
//      - Added view controller to the main storyboard
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import UIKit
import SpriteKit

class BubbleViewController: UIViewController {
    
    var countdownScene: CountdownGameScene!
    var bubbleGameScene: BubbleGameScene!
    
    /* Variables related to game UI */
    var gameCountdown: Int = 60
    var currentScore: Int = 0
    
    let HUDView: UIView = {
        let view = UIView()
        //view.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        //view.backgroundColor = .green
        return view
    }()

    let countdownView: UIView = {
        let view = UIView()
        //view.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        //view.backgroundColor = .green
        return view
    }()
    
    let timeStaticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time"
        label.textAlignment = .center
        label.textColor = bubbleTextColour
        label.font = bubbleStaticFont
        label.heightAnchor.constraint(equalToConstant: timeStaticLabelHeight).isActive = true
        label.widthAnchor.constraint(equalToConstant: timeStaticLabelWidth).isActive = true
        return label
    }()
    
    let scoreStaticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score"
        label.textAlignment = .center
        label.textColor = bubbleTextColour
        label.font = bubbleStaticFont
        label.heightAnchor.constraint(equalToConstant: scoreStaticLabelHeight).isActive = true
        label.widthAnchor.constraint(equalToConstant: scoreStaticLabelWidth).isActive = true
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time"
        label.textAlignment = .center
        label.font = bubbleFont
        label.textColor = bubbleTextColour
        label.heightAnchor.constraint(equalToConstant: timeLabelHeight).isActive = true
        label.widthAnchor.constraint(equalToConstant: timeLabelWidth).isActive = true
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score"
        label.textAlignment = .center
        label.font = bubbleFont
        label.textColor = bubbleTextColour
        label.heightAnchor.constraint(equalToConstant: scoreLabelHeight).isActive = true
        label.widthAnchor.constraint(equalToConstant: scoreLabelWidth).isActive = true
        return label
    }()
    
    let countdownLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = countdownTextColour
        label.font = countdownFont
        //label.heightAnchor.constraint(equalToConstant: countdownLabelHeight).isActive = true
        //label.widthAnchor.constraint(equalToConstant: countdownLabelWidth).isActive = true
        
        return label
    }()
    
    
    /**
     Function runs when this current view has been loaded. Creates countdown scene and transitions to it
     
     - Returns: None.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
        
        view.addSubview(countdownView)
        countdownView.addSubview(countdownLabel)
        
        countdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        countdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        countdownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        countdownView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countdownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        startInitialCountdown()
    }
    
    /**
     Hides the status bar from view when this view is presented
     
     - Returns: None.
     */
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func loadView() {
        self.view = SKView()
    }
    
    func setupGameUI(){
        countdownView.removeFromSuperview()
        view.addSubview(HUDView)
        
        HUDView.addSubview(timeStaticLabel)
        HUDView.addSubview(scoreStaticLabel)
        HUDView.addSubview(timeLabel)
        HUDView.addSubview(scoreLabel)
        
        timeStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0).isActive = true
        timeStaticLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        
        scoreStaticLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0).isActive = true
        scoreStaticLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        
        timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0).isActive = true
        timeLabel.topAnchor.constraint(equalTo: timeStaticLabel.topAnchor, constant: timeStaticLabelHeight + 8.0).isActive = true
        
        scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: scoreStaticLabel.topAnchor, constant: scoreStaticLabelHeight + 8.0).isActive = true
    }
    
    /**
     Initializes the first scene and displays it on the screen.
     
     - Returns: None.
     */
    func startInitialCountdown() {
        let skView = view as! SKView
        
        print("Set up Countdown")
        
        setupCountdownScene()
        
        let transition:SKTransition = SKTransition.fade(withDuration: 0.5)
        let scene:SKScene = BCountdownGameScene(size: (self.view?.bounds.size)!, parent: self)
        skView.presentScene(scene, transition: transition)

    }
    
    
    /**
     Hides the main UI of the game containing the time and score during the countdown
     
     - Returns: None.
     */
    func setupCountdownScene() {
        HUDView.isHidden = true
        //timeScoreUI.isHidden = true
        timeLabel.text = String(gameCountdown)
        scoreLabel.text = String(currentScore)
    }
    
    /**
     Sets the Bubble Game Scene to nil to allow ARC to remove it and deinitialize the scene
     
     - Returns: None.
     */
    override func viewDidDisappear(_ animated: Bool) {
        if (self.view as? SKView) != nil{
            self.bubbleGameScene = nil
        }
    }
    
}

