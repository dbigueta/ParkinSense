//-----------------------------------------------------------------
//  File: TiltUIViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng, Dexter Bigueta, Hamlet Jiang Su
//
//  Description: Main menu of Tilt - controls sounds, start and exit of game
//
//  Changes:
//      - Added IBOutlets to buttons
//      - Added View Controller
//
//  Known Bugs:
//      - Sound only works in iPhoneXR and does not stop after the Tilt Game
//
//-----------------------------------------------------------------

import UIKit
import AVFoundation

class TiltUIViewController: UIViewController {

    @IBOutlet weak var startGame: UIButton!
    
    @IBOutlet weak var quitGame: UIButton!
    
    var soundEffect: AVAudioPlayer = AVAudioPlayer()
    
    
    /**
        Loads the view on the screen - adds buttons and sound toggle
     
         - Returns: None
    **/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startGame.layer.cornerRadius = 25 // Rounded Start Button
        self.quitGame.layer.cornerRadius = 25 // Rounded Quit Button
        
        guard let musicFile = Bundle.main.path(forResource: "Roots", ofType: ".mp3") else {
            print("File Not Found")
            return
        }
        
        do {
            try soundEffect = AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile))
            soundEffect.numberOfLoops = -1
        }
        catch {
            print(error)
        }
        
        soundEffect.play()
    }
    
    
    /**
        Sets sound to be on/off based on the toggle
     
         - Returns: None
    **/
    @IBAction func soundToggle(_ sender: UISwitch) {
        if (sender.isOn == false)
        {
            soundEffect.pause()
        }
        else{
            soundEffect.play()
        }
    }
    
    
    /**
        Stops the sound from playing
     
         - Returns: None
    **/
    @IBAction func stopSound(_ sender: Any) {
        soundEffect.stop()
    }
    
    
    /**
        Starts the game Tilt
     
         - Returns: None
    **/
    @IBAction func startTheGame(_ sender: Any) {
    }
    
}
