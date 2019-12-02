//-----------------------------------------------------------------
//  File: BubbleGameScene.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Jerry Bao, Hamlet Jiang Su
//
//  Description: Main Bubble class that handles generation of target, timer, score, and movement of game items
//
//  Changes:
//      - Refactored code to programmatically code UI elements
//      - Added comments to clarify code
//      - Added transition to Score Scene when count reaches 0
//      - Added the game scene
//
//  Known Bugs:
//      - Scene sometimes generates bubbles too fast
//
//-----------------------------------------------------------------

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
        self.scene!.backgroundColor = bubbleGameBackgroundColour
        showGameUI()
        startCounter()
        generateBubble()
    }
    
    func showGameUI(){
        viewController.HUDView.isHidden = false
    }
    
    func startCounter(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc func decrementCounter() {
        if counter == 0 {
            counterTimer.invalidate()
            endGame()
        }
        else {
            counter -= 1
            viewController.timeLabel.text = String(counter)
        }
    }
    
    func endGame() {
        bubble.removeFromParent()
        
        removeAllChildren()
        removeAllActions()
        removeFromParent()
        
        bubbleFinalScore = viewController.currentScore
        
        viewController.HUDView.isHidden = true
        
        let bubbleScoreViewController:BubbleScoreViewController = BubbleScoreViewController()
        bubbleScoreViewController.modalPresentationStyle = .fullScreen
        viewController.present(bubbleScoreViewController, animated: true, completion: nil)
    }
    
    deinit {
        print("The Bubble Pop Game View has been removed from memory")
    }
    
    func generateBubble(){
        bubble.removeFromParent()
        
        bubble.position = randomBubblePosition()
        bubble.strokeColor = bubbleBallColour
        bubble.fillColor = bubbleBallColour
        
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
                viewController.scoreLabel.text = String(viewController.currentScore)
                generateBubble()
                
            }
        }
    }
    
    
    
}
