//-----------------------------------------------------------------
//  File: TiltGameScene.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Hamlet Jiang Su
//
//  Description: Main TILT class that handles generation of ball/hole, timer, score, and movement of game items
//
//  Changes:
//      - Added comments to clarify code
//      - Added transition to Score Scene when count reaches 0
//      - Added movement of ball using the accelerometer
//      - Added constraints to screen to make sure ball and hole dont appear off-screen
//      - Added generation of ball and hole
//      - Added the game scene
//
//  Known Bugs:
//      - Scene does not immediately generate ball/hole when replaying the game
//      - Score counts up when half the ball is within the hole - whole ball should be in the hole
//          to have score count up
//
//-----------------------------------------------------------------

import SpriteKit
import CoreMotion

class TiltGameScene: SKScene {
    
    let viewController: TiltViewController
    var motionManager = CMMotionManager()
    
    /* Only used with simulator */
    var lastTouchPosition: CGPoint?
    
    /* Variables used for ball */
    var ball = SKShapeNode(circleOfRadius: 40)
    var ballRadius: CGFloat = 50
    var ballSensitivity = 5.0
    var ballLinearDamping: CGFloat = 1.0
    
    /* Variables to keep track of screen size limitations */
    var xRange: SKRange?
    var yRange: SKRange?
    
    /* Variables used for hole */
    var hole = SKShapeNode(circleOfRadius: 70)
    var holeRadius: CGFloat = 70
    var xHolePosition: CGFloat = 0.0
    var yHolePosition: CGFloat = 0.0
    var setMarginX: CGFloat = 20
    var setMarginY: CGFloat = 30
    var holeGenerationRate = 5
    
    /* Variables used to keep track of the timer */
    var counter = 60
    var counterTimer = Timer()
    
    
    /**
     Class constructor - obtains the parent class to be able to access IBOutlets
     
     - Returns: None.
     */
    init(size: CGSize, parent: TiltViewController) {
        print("Tilt Game Scene Initialized")
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
     Function runs when this current scene has been placed onto the view. Controls the main gameplay elements
     
     - Returns: None.
     */
    override func didMove(to view: SKView) {
        motionManager.startAccelerometerUpdates()
        
        physicsWorld.gravity = .zero
        
        showGameUI()
        startCounter()
        generateBall()
    }
    
    
    /**
     Displays game UI elements at the start of the game
     
     - Returns: None.
     */
    func showGameUI() {
        viewController.timeScoreUI.isHidden = false
    }
    
    
    /**
     Starts the game timer to keep track of time remaining
     
     - Returns: None.
     */
    func startCounter() {
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    
    /**
     Helper function for the counter - also used for hole generation
     
     - Returns: None.
     */
    @objc func decrementCounter() {
        if (counter % holeGenerationRate == 0){
            generateHole()
        }
        
        if counter == 0 {
            counterTimer.invalidate()
            endGame()
        }
        else {
            counter -= 1
            viewController.timeLabel.text = String(counter)
        }
    }
    
    
    /**
     Ends the game by removing the ball and the hole, and transitions to the score scene.
     
     - Returns: None.
     */
    func endGame() {
        motionManager.stopAccelerometerUpdates()
        hole.removeFromParent()
        ball.removeFromParent()
        
        removeAllChildren()
        removeAllActions()
        removeFromParent()
        
        viewController.performSegue(withIdentifier: "tiltScore", sender: self)
    }
    
    
    /**
     Deinitializes the scene from memory.

     - Returns: None.
    */
    deinit {
        print("The Tilt Game Scene has been removed from memory")
    }
    
    
    /**
     Generates the Ball controlled by the user.
     
     - Returns: None.
     */
    func generateBall() {
        ball.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(ballRadius))
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.linearDamping = ballLinearDamping
        
        xRange = SKRange(lowerLimit:CGFloat(ballRadius),upperLimit:size.width - CGFloat(ballRadius))
        yRange = SKRange(lowerLimit:CGFloat(ballRadius),upperLimit:size.height - CGFloat(ballRadius))
          
        
        ball.constraints = [SKConstraint.positionX(xRange!,y:yRange!)]
        
        ball.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        ball.fillColor = SKColor.white
        
        self.addChild(ball)
    }
    
    
    /**
     Generates a new Hole and displays the new target on the screen.
     
     - Returns: None.
     */
    func generateHole() {
        hole.removeFromParent()
        
        hole.position = randomHolePosition()
        hole.strokeColor = SKColor.red
        
        self.addChild(hole)
    }
    
    
    /**
     Generates a  random (x, y) position for a Hole.
     
     - Returns: CGPoint containing xPosition and yPosition.
     */
    func randomHolePosition() -> CGPoint {
        xHolePosition = CGFloat(arc4random_uniform(UInt32((view?.bounds.maxX)! + 1)))
        yHolePosition = CGFloat(arc4random_uniform(UInt32((view?.bounds.maxY)! + 1)))
        
        /* Checks and ensures that the hole stays within the screen bounds */
        if xHolePosition < holeRadius {
            xHolePosition = holeRadius + setMarginX
        }
        else if xHolePosition > (view?.bounds.maxX)! - holeRadius {
            xHolePosition = (view?.bounds.maxX)! - holeRadius - setMarginX
        }
        
        if yHolePosition < holeRadius {
            yHolePosition = holeRadius + setMarginY
        }
        else if yHolePosition > ((view?.bounds.maxY)! - holeRadius) {
            yHolePosition = (view?.bounds.maxY)! - holeRadius - setMarginY
        }
        
        return CGPoint(x: xHolePosition, y: yHolePosition)
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
    
    
    /**
     Updates the position of the ball and increases the score counter
     
     - TODO: score should only count up when the whole ball is in the hole
     
     - Parameter currentTime: TimeInterval.
     
     - Returns: None.
     */
    override func update(_ currentTime: TimeInterval) {
        #if targetEnvironment(simulator)
        if let currentTouch = lastTouchPosition {
            let diff = CGPoint(x: currentTouch.x - ball.position.x, y: currentTouch.y - ball.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * ballSensitivity, dy: accelerometerData.acceleration.y * ballSensitivity)
        }
        #endif
        
        if hole.frame.contains(ball.position) {
            viewController.currentScore += 1
            viewController.scoreLabel.text = String(viewController.currentScore)
            
            if let accelerometerData = motionManager.accelerometerData {
                let x = accelerometerData.acceleration.x
                let y = accelerometerData.acceleration.y
                let z = accelerometerData.acceleration.z
                
                print("Acceleration X: \(x) Y: \(y) Z: \(z)")
            }
        }
    }
}
