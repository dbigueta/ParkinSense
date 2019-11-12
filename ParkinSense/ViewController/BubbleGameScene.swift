//
//  BubbleGameScene.swift
//  ParkinSense
//
//  Created by 包立诚 on 2019/11/10.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

import SpriteKit

class BubbleGameScene: SKScene {
    let viewController: BubbleViewController
    
    var lastTouchPosition: CGPoint?
    
    var xRange: SKRange?
    var yRange: SKRange?
    
    var bubble = SKShapeNode(circleOfRadius: 40)
    var bubbleRadius: CGFloat = 40
    var xBubblePosition: CGFloat = 0.0
    var yBubblePosition: CGFloat = 0.0
    var setMarginX: CGFloat = 20
    var setMarginY: CGFloat = 30
    var bubbleGenerationRate = 3
    
    var counter = 30
    var counterTimer = Timer()
    
    
    init(size: CGSize, parent: BubbleViewController){
        print("Bubble Pop Game Scene Initialized")
        self.viewController = parent
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        
        showGameUI()
        startCounter()
        //generateBubble()
    }
    
    func showGameUI(){
        viewController.BubbleTimeScoreUI.isHidden = false
    }
    
    func startCounter(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc func decrementCounter() {
        if (counter % bubbleGenerationRate == 0){
            generateBubble()
        }
        
        if counter == 0 {
            counterTimer.invalidate()
            endGame()
        }
        else {
            counter -= 1
            viewController.BubbleTimeLabel.text = String(counter)
        }
    }
    
    func endGame() {
        bubble.removeFromParent()
        
        removeAllChildren()
        removeAllActions()
        removeFromParent()
        
        viewController.performSegue(withIdentifier: "bubbleScore", sender: self)
    }
    
    deinit {
        print("The Bubble Pop Game Scene has been removed from memory")
    }
    
    func generateBubble(){
        bubble.removeFromParent()
        
        bubble.position = randomBubblePosition()
        bubble.fillColor = SKColor.red
        
        self.addChild(bubble)
        
    }
    
    func randomBubblePosition() -> CGPoint {
        xBubblePosition = CGFloat(arc4random_uniform(UInt32((view?.bounds.maxX)! + 1)))
        yBubblePosition = CGFloat(arc4random_uniform(UInt32((view?.bounds.maxY)! + 1)))
        
        /* Checks and ensures that the bubble stays within the screen bounds */
        if xBubblePosition < bubbleRadius {
            xBubblePosition = bubbleRadius + setMarginX
        }
        else if xBubblePosition > (view?.bounds.maxX)! - bubbleRadius {
            xBubblePosition = (view?.bounds.maxX)! - bubbleRadius - setMarginX
        }
        
        if yBubblePosition < bubbleRadius {
            yBubblePosition = bubbleRadius + setMarginY
        }
        else if yBubblePosition > ((view?.bounds.maxY)! - bubbleRadius) {
            yBubblePosition = (view?.bounds.maxY)! - bubbleRadius - setMarginY
        }
        
        return CGPoint(x: xBubblePosition, y: yBubblePosition)
        
        
    }
    
    
    /**
     Override function for a touch event on the screen - only used for simulator as simulator does not contain accelerometer
     
     - Returns: None.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    
    /**
     Override function for a touch event on the screen - only used for simulator as simulator does not contain accelerometer
     
     - Returns: None.
     */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    
    /**
     Override function for a touch event on the screen - only used for simulator as simulator does not contain accelerometer
     
     - Returns: None.
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func update(_ currentTime: TimeInterval){
        
        if let currentTouch = lastTouchPosition{
            if ((bubble.position.x - bubbleRadius < currentTouch.x) && (currentTouch.x < bubble.position.x + bubbleRadius) && (bubble.position.y - bubbleRadius < currentTouch.y) && (currentTouch.y < bubble.position.y + bubbleRadius)){
                viewController.currentScore += 1
                viewController.BubbleScoreLabel.text = String(viewController.currentScore)
                
            }
        }
//        if bubble.frame.contains(currentTouch){
//            viewController.currentScore += 1
//            viewController.BubbleScoreLabel.text = String(viewController.currentScore)
//        }
        
    }
    
    
    
}
