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

    let tiltLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TILT"
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: tiltLabelHeight).isActive = true
        return label
    }()
    
    let instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Move your ball towards the target. Keep your hand as steady as possible. Good Luck"
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: instructionsLabelHeight).isActive = true
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: startButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: startButtonHeight).isActive = true
        return button
    }()
    
    let soundLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sound Effects"
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: soundLabelHeight).isActive = true
        return label
    }()
    
    let soundToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.addTarget(self, action: #selector(soundTogglePressed(_:)), for: .touchUpInside)
        return toggle
    }()
    
    let quitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Quit", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(buttonTextColour, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(quitGame(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: quitButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: quitButtonHeight).isActive = true
        return button
    }()
    
    var soundEffect: AVAudioPlayer = AVAudioPlayer()
    
    
    /**
        Loads the view on the screen - adds buttons and sound toggle
     
         - Returns: None
    **/
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
        
        view.addSubview(tiltLabel)
        view.addSubview(instructionsLabel)
        view.addSubview(startButton)
        view.addSubview(soundLabel)
        view.addSubview(soundToggle)
        view.addSubview(quitButton)
        
        tiltLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tiltLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tiltLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true

        instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        instructionsLabel.topAnchor.constraint(equalTo: tiltLabel.topAnchor, constant: tiltLabelHeight + 16).isActive = true
        
        startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        startButton.topAnchor.constraint(equalTo: instructionsLabel.topAnchor, constant: instructionsLabelHeight + 16).isActive = true
        
        soundLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        soundLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        soundLabel.topAnchor.constraint(equalTo: startButton.topAnchor, constant: startButtonHeight + 16).isActive = true
        
        soundToggle.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        soundToggle.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        soundToggle.topAnchor.constraint(equalTo: startButton.topAnchor, constant: startButtonHeight + 16).isActive = true

        quitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        quitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        quitButton.topAnchor.constraint(equalTo: soundLabel.topAnchor, constant: soundLabelHeight + 16).isActive = true
        
        setupSound()
    }
    
    
    func setupSound() {
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
    @objc func soundTogglePressed(_ sender: UISwitch) {
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
    @objc func stopSound(_ sender: Any) {
        soundEffect.stop()
    }
    
    
    /**
        Starts the game Tilt
     
         - Returns: None
    **/
    @objc func startGame(_ sender: Any) {
        let tiltViewController:TiltViewController = TiltViewController()
        self.present(tiltViewController, animated: true, completion: nil)
    }
    
    /**
        Quits the game Tilt
     
         - Returns: None
    **/
    @objc func quitGame(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
