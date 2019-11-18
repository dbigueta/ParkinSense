//-----------------------------------------------------------------
//  File: TiltViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Hamlet Jiang Su
//
//  Description: Main TILT view controller that presents the countdown and tilt game scenes
//
//  Changes:
//      - Added comments to clarify code
//      - Added viewDidDisappear() and prepare() to transtition over to the Tilt Score View
//      - Added functions that help set up the countdown scene and transition to it
//      - Added view controller to the main storyboard
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import UIKit
import SpriteKit

class TiltViewController: UIViewController {
    
    let HUDView: UIView = {
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
        label.heightAnchor.constraint(equalToConstant: timeStaticLabelHeight).isActive = true
        return label
    }()
    
    let scoreStaticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score"
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: scoreStaticLabelHeight).isActive = true
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time"
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: tiltLabelHeight).isActive = true
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score"
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: instructionsLabelHeight).isActive = true
        return label
    }()
    
    /**
     Function runs when this current view has been loaded. Creates countdown scene and transitions to it
     
     - Returns: None.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
         
         self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
         
        view.addSubview(HUDView)
         HUDView.addSubview(timeStaticLabel)
         HUDView.addSubview(scoreStaticLabel)
         HUDView.addSubview(timeLabel)
         HUDView.addSubview(scoreLabel)

         
         timeStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         timeStaticLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         timeStaticLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        scoreStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scoreStaticLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scoreStaticLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true

         timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         timeLabel.topAnchor.constraint(equalTo: timeStaticLabel.topAnchor, constant: timeStaticLabelHeight + 16).isActive = true
        
        scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: scoreStaticLabel.topAnchor, constant: scoreStaticLabelHeight + 16).isActive = true
        
        startInitialCountdown()
    }
    
    var countdownScene: CountdownGameScene!
    var tiltGameScene: TiltGameScene!
    
    /* Variables related to game UI */
    var gameCountdown: Int = 60
    var currentScore: Int = 0
    
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
    
    
    /**
     Initializes the first scene and displays it on the screen.

     - Returns: None.
    */
    func startInitialCountdown() {
        let skView = view as! SKView
        
        skView.showsFPS = true
        
        print("Set up Countdown")
        
        countdownScene = CountdownGameScene(size: skView.bounds.size, parent: self)
        countdownScene.scaleMode = .aspectFill
        countdownScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        tiltGameScene = TiltGameScene(size: skView.bounds.size, parent: self)
        tiltGameScene.scaleMode = .aspectFill
        
        setupCountdownScene()
        
        skView.presentScene(countdownScene)
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
     Prepares the new view and passes over the score variable to the new view
     
     - Returns: None.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is TiltScoreViewController
        {
            let vc = segue.destination as? TiltScoreViewController
            vc?.fScore = currentScore
        }
    }
    
    
    /**
     Sets the Tilt Game Scene to nil to allow ARC to remove it and deinitialize the scene
     
     - Returns: None.
     */
    override func viewDidDisappear(_ animated: Bool) {
        if (self.view as? SKView) != nil{
            self.tiltGameScene = nil
        }
    }

}

