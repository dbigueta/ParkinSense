//-----------------------------------------------------------------
//  File: BubbleUIViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng, Dexter Bigueta, Hamlet Jiang Su
//
//  Description: Main menu of bubble - controls sounds, start and exit of game
//
//  Changes:
//      - Added IBOutlets to buttons
//      - Added View Controller
//
//  Known Bugs:
//      - Sound only works in iPhoneXR and does not stop after the bubble Game
//
//-----------------------------------------------------------------

import UIKit
import AVFoundation

class BubbleUIViewController: UIViewController {

    let bubbleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BUBBLE POP"
        label.textAlignment = .center
        label.font = bubbleTitleFont
        label.textColor = bubbleTextColour
        label.heightAnchor.constraint(equalToConstant: bubbleLabelHeight).isActive = true
        return label
    }()
    
    let instructionsLabelLine1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Move your ball towards the target"
        label.textAlignment = .center
        label.textColor = bubbleTextColour
        label.heightAnchor.constraint(equalToConstant: instructionsLabelHeight).isActive = true
        return label
    }()
    
    let instructionsLabelLine2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Keep your hand as steady as possible"
        label.textAlignment = .center
        label.textColor = bubbleTextColour
        label.heightAnchor.constraint(equalToConstant: instructionsLabelHeight).isActive = true
        return label
    }()
    
    let instructionsLabelLine3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Good Luck!"
        label.textAlignment = .center
        label.textColor = bubbleTextColour
        label.heightAnchor.constraint(equalToConstant: instructionsLabelHeight).isActive = true
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.setTitleColor(bubbleTextColour, for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = bubbleButtonColour
        button.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: startButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: startButtonHeight).isActive = true
        return button
    }()
    
    let soundLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sound Effects"
        label.textAlignment = .right
        label.textColor = bubbleTextColour
        label.heightAnchor.constraint(equalToConstant: soundLabelHeight).isActive = true
        label.widthAnchor.constraint(equalToConstant: soundLabelWidth).isActive = true
        return label
    }()
    
    let soundToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.setOn(true, animated: false)
        toggle.addTarget(self, action: #selector(soundTogglePressed(_:)), for: .touchUpInside)
        toggle.widthAnchor.constraint(equalToConstant: soundToggleWidth).isActive = true
        return toggle
    }()
    
    let quitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Quit", for: .normal)
        button.setTitleColor(bubbleTextColour, for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = bubbleButtonColour
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
        
        self.view.backgroundColor = bubbleBackgroundColour
        
        view.addSubview(bubbleLabel)
        view.addSubview(instructionsLabelLine1)
        view.addSubview(instructionsLabelLine2)
        view.addSubview(instructionsLabelLine3)
        view.addSubview(startButton)
        view.addSubview(soundLabel)
        view.addSubview(soundToggle)
        view.addSubview(quitButton)
        
        bubbleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bubbleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bubbleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 224.0).isActive = true

        instructionsLabelLine1.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instructionsLabelLine1.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        instructionsLabelLine1.topAnchor.constraint(equalTo: bubbleLabel.topAnchor, constant: bubbleLabelHeight + 32.0).isActive = true
        
        instructionsLabelLine2.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instructionsLabelLine2.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        instructionsLabelLine2.topAnchor.constraint(equalTo: instructionsLabelLine1.topAnchor, constant: instructionsLabelHeight + 4.0).isActive = true
        
        instructionsLabelLine3.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instructionsLabelLine3.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        instructionsLabelLine3.topAnchor.constraint(equalTo: instructionsLabelLine2.topAnchor, constant: instructionsLabelHeight + 4.0).isActive = true
        
        startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: bubbleStartButtonOffset).isActive = true
        startButton.topAnchor.constraint(equalTo: instructionsLabelLine3.topAnchor, constant: instructionsLabelHeight + 40.0).isActive = true
        
        soundLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        soundLabel.topAnchor.constraint(equalTo: startButton.topAnchor, constant: startButtonHeight + 24.0).isActive = true
        
        soundToggle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: soundLabelWidth + 56.0).isActive = true
        soundToggle.topAnchor.constraint(equalTo: startButton.topAnchor, constant: startButtonHeight + 24.0).isActive = true

        quitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: bubbleQuitButtonOffset).isActive = true
        quitButton.topAnchor.constraint(equalTo: soundLabel.topAnchor, constant: soundLabelHeight + 24.0).isActive = true
        
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
        Starts the game bubble
     
         - Returns: None
    **/
    @objc func startGame(_ sender: Any) {
        let bubbleViewController:BubbleViewController = BubbleViewController()
        self.present(bubbleViewController, animated: true, completion: nil)
    }
    
    /**
        Quits the game bubble
     
         - Returns: None
    **/
    @objc func quitGame(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
