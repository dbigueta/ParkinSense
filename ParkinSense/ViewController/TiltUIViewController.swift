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
//      - Refactored code to programmatically code UI elements
//      - Added IBOutlets to buttons
//      - Added View Controller
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import UIKit
import AVFoundation

class TiltUIViewController: UIViewController {
    
    // App Logo UI Image
    let gameImageView: UIImageView = {
        let imageView = UIImageView(image: tiltImage)
        Utilities.styleImageView(imageView)
        return imageView
    }()
    
    // Tilt Title UI label
    let tiltLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TILT"
        label.textAlignment = .center
        label.font = tiltTitleFont
        label.textColor = tiltTextColour
        label.heightAnchor.constraint(equalToConstant: tiltLabelHeight).isActive = true
        return label
    }()
    
    //First line of instructions
    let instructionsLabelLine1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Move the ball towards by tilting your phone"
        label.textAlignment = .center
        label.textColor = tiltTextColour
        label.heightAnchor.constraint(equalToConstant: instructionsLabelHeight).isActive = true
        return label
    }()
    
    //Second line of instructions
    let instructionsLabelLine2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Keep the ball inside the target at all times"
        label.textAlignment = .center
        label.textColor = tiltTextColour
        label.heightAnchor.constraint(equalToConstant: instructionsLabelHeight).isActive = true
        return label
    }()
    
    //Third line of instructions
    let instructionsLabelLine3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Good Luck!"
        label.textAlignment = .center
        label.textColor = tiltTextColour
        label.heightAnchor.constraint(equalToConstant: instructionsLabelHeight).isActive = true
        return label
    }()
    
    //Start game button
    let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START", for: .normal)
        button.setTitleColor(tiltButtonTextColour, for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = tiltButtonColour
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        button.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: startButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: startButtonHeight).isActive = true
        return button
    }()
    
    //Sound UI label
    let soundLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sound Effects"
        label.textAlignment = .right
        label.textColor = tiltTextColour
        label.heightAnchor.constraint(equalToConstant: soundLabelHeight).isActive = true
        label.widthAnchor.constraint(equalToConstant: soundLabelWidth).isActive = true
        return label
    }()
    
    //Sound Toggle
    let soundToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.setOn(true, animated: false)
        toggle.addTarget(self, action: #selector(soundTogglePressed(_:)), for: .touchUpInside)
        toggle.widthAnchor.constraint(equalToConstant: soundToggleWidth).isActive = true
        return toggle
    }()
    
    //Quit game button
    let quitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("QUIT", for: .normal)
        button.setTitleColor(tiltButtonTextColour, for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = tiltButtonColour
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        button.addTarget(self, action: #selector(quitGame(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: quitButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: quitButtonHeight).isActive = true
        return button
    }()
    
    var soundEffect: AVAudioPlayer?
    
    
    /**
     Loads the view on the screen - adds buttons and sound toggle
     
     - Returns: None
     **/
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Sets background colour of view
        self.view.backgroundColor = tiltBackgroundColour
        
        //Add all labels, buttons, toggles into the view
        view.addSubview(gameImageView)
        view.addSubview(tiltLabel)
        view.addSubview(instructionsLabelLine1)
        view.addSubview(instructionsLabelLine2)
        view.addSubview(instructionsLabelLine3)
        view.addSubview(startButton)
        view.addSubview(soundLabel)
        view.addSubview(soundToggle)
        view.addSubview(quitButton)
        
        gameImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0).isActive = true
        gameImageView.heightAnchor.constraint(equalToConstant: gameImageHeight).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
               
        
        //Sets up all the constraints needed for the labels, buttons, toggles
        tiltLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tiltLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tiltLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: gameImageHeight + 24.0).isActive = true
        
        instructionsLabelLine1.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instructionsLabelLine1.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        instructionsLabelLine1.topAnchor.constraint(equalTo: tiltLabel.topAnchor, constant: tiltLabelHeight + 32.0).isActive = true
        
        instructionsLabelLine2.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instructionsLabelLine2.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        instructionsLabelLine2.topAnchor.constraint(equalTo: instructionsLabelLine1.topAnchor, constant: instructionsLabelHeight + 4.0).isActive = true
        
        instructionsLabelLine3.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instructionsLabelLine3.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        instructionsLabelLine3.topAnchor.constraint(equalTo: instructionsLabelLine2.topAnchor, constant: instructionsLabelHeight + 4.0).isActive = true
        
        startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tiltStartButtonOffset).isActive = true
        startButton.topAnchor.constraint(equalTo: instructionsLabelLine3.topAnchor, constant: instructionsLabelHeight + 40.0).isActive = true
        
        soundLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        soundLabel.topAnchor.constraint(equalTo: startButton.topAnchor, constant: startButtonHeight + 24.0).isActive = true
        
        soundToggle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: soundLabelWidth + 56.0).isActive = true
        soundToggle.topAnchor.constraint(equalTo: startButton.topAnchor, constant: startButtonHeight + 24.0).isActive = true
        
        quitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tiltQuitButtonOffset).isActive = true
        quitButton.topAnchor.constraint(equalTo: soundLabel.topAnchor, constant: soundLabelHeight + 24.0).isActive = true
        
        setupSound()
    }
    
    
    func setupSound() {
        
        guard let musicFile = Bundle.main.path(forResource: "Roots", ofType: ".mp3") else {
            print("File Not Found")
            return
        }
        
        try? soundEffect = AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile))
        soundEffect?.numberOfLoops = -1
        
        soundEffect?.play()
    }
    
    /**
     Sets sound to be on/off based on the toggle
     
     - Returns: None
     **/
    @objc func soundTogglePressed(_ sender: UISwitch) {
        if (sender.isOn == false)
        {
            soundEffect?.pause()
        }
        else{
            soundEffect?.play()
        }
    }
    
    
    /**
     Stops the sound from playing
     
     - Returns: None
     **/
    @objc func stopSound(_ sender: Any) {
        soundEffect?.stop()
    }
    
    
    /**
     Starts the game Tilt
     
     - Returns: None
     **/
    @objc func startGame(_ sender: Any) {
        let tiltViewController:TiltViewController = TiltViewController()
        tiltViewController.modalPresentationStyle = .fullScreen
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
