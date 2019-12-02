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
        Utilities.styleImageView(imageView) // Style game icon
        return imageView
    }()
    
    // Tilt Title UI label
    let tiltLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TILT" // Set label text
        label.textAlignment = .center // Set text alignment
        label.font = tiltTitleFont // Set label font
        label.textColor = tiltTextColour // Set label font colour
        label.heightAnchor.constraint(equalToConstant: tiltLabelHeight).isActive = true
        return label
    }()
    
    //First line of instructions
    let instructionsLabelLine1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Move the ball towards by tilting your phone" // Set label text
        label.textAlignment = .center // Set text alignment
        label.textColor = tiltTextColour // Set label font colour
        label.heightAnchor.constraint(equalToConstant: instructionsLabelHeight).isActive = true
        return label
    }()
    
    //Second line of instructions
    let instructionsLabelLine2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Keep the ball inside the target at all times" // Set label text
        label.textAlignment = .center // Set text alignment
        label.textColor = tiltTextColour // Set label font colour
        label.heightAnchor.constraint(equalToConstant: instructionsLabelHeight).isActive = true // Set label height
        return label
    }()
    
    //Third line of instructions
    let instructionsLabelLine3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Good Luck!" // Set label text
        label.textAlignment = .center // Set text alignment
        label.textColor = tiltTextColour // Set label font colour
        label.heightAnchor.constraint(equalToConstant: instructionsLabelHeight).isActive = true // Set label height
        return label
    }()
    
    //Start game button
    let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START", for: .normal) // Set button label text
        button.setTitleColor(tiltButtonTextColour, for: .normal) // Set button label text colour
        button.layer.cornerRadius = 25 // Make button have rounded corners
        button.backgroundColor = tiltButtonColour // Set button background colour
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium) // Set button label font size
        button.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside) // Set function to be triggered if button is tapped
        button.widthAnchor.constraint(equalToConstant: startButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: startButtonHeight).isActive = true // Set button height
        return button
    }()
    
    //Sound UI label
    let soundLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sound Effects" // Set label text
        label.textAlignment = .right // Set text alignment
        label.textColor = tiltTextColour // Set label font colour
        label.heightAnchor.constraint(equalToConstant: soundLabelHeight).isActive = true // Set label height
        label.widthAnchor.constraint(equalToConstant: soundLabelWidth).isActive = true // Set label width
        return label
    }()
    
    //Sound Toggle
    let soundToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.setOn(true, animated: false) // Set default toggle status of toggle
        toggle.addTarget(self, action: #selector(soundTogglePressed(_:)), for: .touchUpInside) // Set function to be triggered if toggled
        toggle.widthAnchor.constraint(equalToConstant: soundToggleWidth).isActive = true // Set toggle width
        return toggle
    }()
    
    //Quit game button
    let quitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("QUIT", for: .normal) // Set button label text
        button.setTitleColor(tiltButtonTextColour, for: .normal) // Set button label text colour
        button.layer.cornerRadius = 25 // Make button have rounded corners
        button.backgroundColor = tiltButtonColour // Set button background colour
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .medium) // Set button label font size
        button.addTarget(self, action: #selector(quitGame(_:)), for: .touchUpInside) // Set function to be triggered if button is tapped
        button.widthAnchor.constraint(equalToConstant: quitButtonWidth).isActive = true // Set button width
        button.heightAnchor.constraint(equalToConstant: quitButtonHeight).isActive = true // Set button height
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
        
        // Set game view constraints to allow for multiple device configurations
        gameImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0).isActive = true
        gameImageView.heightAnchor.constraint(equalToConstant: gameImageHeight).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
               
        // Set tilt title constraints to allow for multiple device configurations
        tiltLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tiltLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tiltLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: gameImageHeight + 24.0).isActive = true
        
        // Set tilt instructions constraints to allow for multiple device configurations
        instructionsLabelLine1.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instructionsLabelLine1.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        instructionsLabelLine1.topAnchor.constraint(equalTo: tiltLabel.topAnchor, constant: tiltLabelHeight + 32.0).isActive = true
        
        // Set tilt instructions constraints to allow for multiple device configurations
        instructionsLabelLine2.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instructionsLabelLine2.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        instructionsLabelLine2.topAnchor.constraint(equalTo: instructionsLabelLine1.topAnchor, constant: instructionsLabelHeight + 4.0).isActive = true
        
        // Set tilt instructions constraints to allow for multiple device configurations
        instructionsLabelLine3.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instructionsLabelLine3.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        instructionsLabelLine3.topAnchor.constraint(equalTo: instructionsLabelLine2.topAnchor, constant: instructionsLabelHeight + 4.0).isActive = true
        
        // Set tilt start button constraints to allow for multiple device configurations
        startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tiltStartButtonOffset).isActive = true
        startButton.topAnchor.constraint(equalTo: instructionsLabelLine3.topAnchor, constant: instructionsLabelHeight + 40.0).isActive = true
        
        // Set sound label constraints to allow for multiple device configurations
        soundLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        soundLabel.topAnchor.constraint(equalTo: startButton.topAnchor, constant: startButtonHeight + 24.0).isActive = true
        
        // Set sound toggle constraints to allow for multiple device configurations
        soundToggle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: soundLabelWidth + 56.0).isActive = true
        soundToggle.topAnchor.constraint(equalTo: startButton.topAnchor, constant: startButtonHeight + 24.0).isActive = true
        
        // Set quit button constraints to allow for multiple device configurations
        quitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tiltQuitButtonOffset).isActive = true
        quitButton.topAnchor.constraint(equalTo: soundLabel.topAnchor, constant: soundLabelHeight + 24.0).isActive = true
        
        setupSound()
    }
    
    /**
     Function that sets up sound again when replaying

     - Returns: None
     **/
    override func viewWillAppear(_ animated: Bool) {
        setupSound()
    }
    
    
    /**
     Function that sets up the sounds and toggles

     - Returns: None
     **/
    func setupSound() {
        
        // retrieve music file from app
        guard let musicFile = Bundle.main.path(forResource: "Roots", ofType: ".mp3") else {
            print("File Not Found")
            return
        }
        
        try? soundEffect = AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile))
        soundEffect?.numberOfLoops = 0 // Set it so that music does not repeat
        
        soundEffect?.play() // Play sounds
    }
    
    /**
     Sets sound to be on/off based on the toggle
     
     - Returns: None
     **/
    @objc func soundTogglePressed(_ sender: UISwitch) {
        if (sender.isOn == false)
        {
            soundEffect?.pause() // Stop sound from playing
        }
        else{
            soundEffect?.play() // Start music
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
