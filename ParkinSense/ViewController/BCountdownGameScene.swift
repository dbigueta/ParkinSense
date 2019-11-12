//
//  BCountdownGameScene.swift
//  ParkinSense
//
//  Created by 包立诚 on 2019/11/10.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

import SpriteKit

class BCountdownGameScene: SKScene {
    
    var countdownLabel: SKLabelNode = SKLabelNode()
    var count: Int = 5
    
    var viewController: BubbleViewController
    
    
    /**
     Class constructor - obtains the parent class to be able to access variables from parent
     
     - Returns: None.
     */
    init(size: CGSize, parent: BubbleViewController) {
        self.viewController = parent
        super.init(size: size)
    }
    
    
    /**
     Required function because of self initialization of init()
     
     - Returns: None.
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
     Function runs when this current scene has been placed onto the view. Controls the countdown
     
     - Returns: None.
     */
    override func didMove(to view: SKView) {
        countdown()
    }
    
    
    /**
     Sets up countdown and displays countdown on the screen.
     
     - Returns: None.
     */
    func countdown() {
        countdownLabel.fontColor = SKColor.black
        countdownLabel.fontSize = 90
        countdownLabel.text = String(count)
        
        addChild(countdownLabel)
        
        let counterDecrement = SKAction.sequence([SKAction.wait(forDuration: 1.0),
                                                  SKAction.run(countdownAction)])
        
        run(SKAction.sequence([SKAction.repeat(counterDecrement, count: count),
                               SKAction.run(endCountdown)]))
    }
    
    
    /**
     Decrements the countdown by 1 and updates label.
     
     - Returns: None.
     */
    func countdownAction(){
        count -= 1
        countdownLabel.text = String(count)
    }
    
    
    /**
     Ends the countdown by removing the countdown from the screen. Starts transition to main game.
     
     - Returns: None.
     */
    func endCountdown() {
        countdownLabel.removeFromParent()
        transitionToGame()
    }
    
    
    /**
     Deinitializes the scene from memory.
     
     - Returns: None.
     */
    deinit {
        print("The Countdown Scene has been removed from memory")
    }
    
    
    /**
     Performs transition to a new scene for the main game.
     
     - TODO: Check to see which game we want to transition to - Tilt/Bubble Pop
     
     - Returns: None.
     */
    func transitionToGame() {
        let transition:SKTransition = SKTransition.fade(withDuration: 0.5)
        let scene:SKScene = BubbleGameScene(size: (self.view?.bounds.size)!, parent: self.viewController)
        self.view?.presentScene(scene, transition: transition)
    }
}
