//-----------------------------------------------------------------
//  File: BCountdownGameScene.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Jerry Bao, Hamlet Jiang Su
//
//  Description: Creates the countdown that happens before a game begins (Bubble Pop)
//
//  Changes:
//      - Refactored code to programmatically code UI elements
//      - Added more comments to make the code more clear
//      - Added deinit() function to check whether or not the scene has been deinitialized
//      - Added transition to the BubbleGameScene
//      - Added countdown timer that displays on the screen
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import SpriteKit

class BCountdownGameScene: SKScene {
    
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
        self.scene?.backgroundColor = countdownBackgroundColour
        countdown()
    }
    
    
    /**
     Sets up countdown and displays countdown on the screen.

     - Returns: None.
    */
    func countdown() {
        viewController.countdownLabel.text = String(count)
        
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
        viewController.countdownLabel.text = String(count)
    }
    
    
    /**
     Ends the countdown by removing the countdown from the screen. Starts transition to main game.

     - Returns: None.
    */
    func endCountdown() {
        viewController.countdownView.isHidden = true
        viewController.setupGameUI()
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
    
     - Returns: None.
    */
    func transitionToGame() {
        let transition:SKTransition = SKTransition.fade(withDuration: 0.5)
        let scene:SKScene = BubbleGameScene(size: (self.view?.bounds.size)!, parent: self.viewController)
        self.view?.presentScene(scene, transition: transition)
    }
}
