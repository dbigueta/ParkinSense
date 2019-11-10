//-----------------------------------------------------------------
//  File: BubbleUIViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng, Licheng Bao (Jerry)
//
//  Changes:
//      - list change here
//
//  Known Bugs:
//      - list known bugs here
//
//-----------------------------------------------------------------

import UIKit
import AVFoundation

class BubbleUIViewController: UIViewController {
    
  
    

    @IBOutlet weak var BubbleQuitGame: UIButton!
    @IBOutlet weak var BubbleStartGame: UIButton!
    var soundEffect: AVAudioPlayer = AVAudioPlayer()
    
    
    /**
     Loads the view on the screen - adds buttons and sound toggle
     
     - Returns: None
     **/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.BubbleStartGame.layer.cornerRadius = 25 // Rounded Start Button
        self.BubbleQuitGame.layer.cornerRadius = 25 // Rounded Quit Button
        
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
    @IBAction func stopSpund(_ sender: Any) {
        soundEffect.stop()
    }
    /**
     
     Starts the game Bubble pop
 
     - Returns: None
 **/
     @IBAction func BubbleStartGame(_ sender: Any) {
     }
 
    
    
}
