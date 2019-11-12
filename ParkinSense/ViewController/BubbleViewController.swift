//
//  BubbleViewController.swift
//  ParkinSense
//
//  Created by 包立诚 on 2019/11/10.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

import UIKit
import SpriteKit

class BubbleViewController: UIViewController {

    @IBOutlet weak var bb: UIButton!
    @IBOutlet weak var BubbleTimeScoreUI: UIStackView!
    @IBOutlet weak var BubbleTimeLabel: UILabel!
    @IBOutlet weak var BubbleScoreLabel: UILabel!
    
    var bubbleGameScene: BubbleGameScene!
    var countdownScene: BCountdownGameScene!
    
    var currentScore: Int = 0
    var gameCountdown: Int = 60
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startInitialCountDown()
    }
    

    
    func startInitialCountDown(){
        
        let skView = view as! SKView
        
        skView.showsFPS = true
        print("Set up Countdown")
        
        countdownScene = BCountdownGameScene(size: skView.bounds.size, parent: self)
        countdownScene.scaleMode = .aspectFill
        countdownScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        bubbleGameScene = BubbleGameScene(size: skView.bounds.size, parent: self)
        bubbleGameScene.scaleMode = .aspectFill
        
        
        setupCountdownScene()
        
        skView.presentScene(countdownScene)
        
        
    }
    
    func setupCountdownScene() {
        BubbleTimeScoreUI.isHidden = true
        BubbleTimeLabel.text = String(gameCountdown)
        BubbleScoreLabel.text = String(currentScore)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
//        if segue.destination is BubbleScoreViewController
//        {
//            let vc = segue.destination as? BubbleScoreViewController
//            vc?.fScore = currentScore
//        }
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

    @IBAction func gameover(_ sender: Any) {
    }
}
