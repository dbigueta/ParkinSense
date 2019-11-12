//-----------------------------------------------------------------
//  File: GameTwoViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng
//
//  Changes:
//      - Added View
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import UIKit
import AVFoundation

class GameTwoViewController: UIViewController {

    @IBOutlet weak var BubbleQuitGame: UIButton!
    @IBOutlet weak var BubbleStartGame: UIButton!
    var soundEffect: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.BubbleQuitGame.layer.cornerRadius = 25
        self.BubbleStartGame.layer.cornerRadius = 25
        
        guard let musicFile = Bundle.main.path(forResource: "Roots", ofType: ".mp3") else{
            print("File Not Found")
            return
        }
        
        do{
            try soundEffect = AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile))
            soundEffect.numberOfLoops = -1
        }
        catch{
            print(error)
        }
        soundEffect.play()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func BubbleSoundToggle(_ sender: UISwitch) {
        if(sender.isOn == false){
            soundEffect.pause()
        }
        else{
            soundEffect.play()
        }
    }
    @IBAction func BubbleStartTheGame(_ sender: Any) {
    }
    
    @IBAction func BubbleQuitTheGame(_ sender: Any) {
        soundEffect.stop()
    }
}
