//
//  BubbleViewController.swift
//  ParkinSense
//
//  Created by 包立诚 on 2019/11/8.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

import UIKit
import SpriteKit

class BubbleViewController: UIViewController {
    
    var countdownScene: CountdownGameScene!
    var bubbleGameScene: BubbleGameScene!
    
    /* Variables related to game UI */
    var gameCountdown: Int = 60
    var currentScore: Int = 0
    
    //MARK: Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeScoreUI: UIStackView!
    
    
    /**
     Hides the status bar from view when this view is presented
     
     - Returns: None.
     */
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    /**
     Function runs when this current view has been loaded. Creates countdown scene and transitions to it
     
     - Returns: None.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startInitialCountdown()
    }
    
    
    /**
     Initializes the first scene and displays it on the screen.
     
     - Returns: None.
     */
    func startInitialCountdown() {
        let skView = view as! SKView
        
        skView.showsFPS = true
        
        print("Set up Countdown")
        //Temporaily comment it
//        countdownScene = CountdownGameScene(size: skView.bounds.size, parent: self)
//        countdownScene.scaleMode = .aspectFill
//        countdownScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        bubbleGameScene = BubbleGameScene(size: skView.bounds.size, parent: self)
        bubbleGameScene.scaleMode = .aspectFill
        
        setupCountdownScene()
        
        skView.presentScene(countdownScene)
    }
    
    
    /**
     Hides the main UI of the game containing the time and score during the countdown
     
     - Returns: None.
     */
    func setupCountdownScene() {
        timeScoreUI.isHidden = true
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
            self.bubbleGameScene = nil
        }
    }
    
}
