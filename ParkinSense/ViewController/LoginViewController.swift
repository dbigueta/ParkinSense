//-----------------------------------------------------------------
//  File: LoginViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng, Hamlet Jiang Su
//
//  Description: Main login view of ParkinSense
//
//  Changes:
//      - Refactored code to programmatically code UI elements
//      - Added authentication to firebase
//      - Added IBOutlets to buttons and checkboxes
//      - Added View Controller
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import UIKit
import FirebaseAuth
import FirebaseDatabase
import BEMCheckBox

class LoginViewController: UIViewController, UITextFieldDelegate {
    // MARK: Class Variables
    
    // App Logo UI Image
    let appImageView: UIImageView = {
        let imageView = UIImageView(image: appImage!)
        Utilities.styleImageView(imageView)
        return imageView
    }()
    
    // App UI Label for "PARKINSENSE"
    let appLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "PARKINSENSE"
        label.font = UIFont.systemFont(ofSize: appLabelHeight, weight: .light)
        return label
    }()
    
    // Slogan UI Label for "SPARK YOUR SENSES"
    let sloganLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "SPARK YOUR SENSES"
        label.font = UIFont.systemFont(ofSize: sloganLabelHeight, weight: .light)
        return label
    }()
    
    // Email UI Textfield to input email address
    let emailTextField: CustomTextField = {
        let textField = CustomTextField()
        Utilities.styleTextField(textField, password: false)
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: textColour])
        textField.paddingValue = paddingVal
        textField.awakeFromNib()
        textField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light)
        textField.keyboardType = UIKeyboardType.emailAddress
        return textField
    }()
    
    // Password UI Textfield to input password
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        Utilities.styleTextField(textField, password: true)
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: textColour])
        textField.paddingValue = paddingVal
        textField.awakeFromNib()
        textField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light)
        textField.keyboardType = UIKeyboardType.default
        return textField
    }()
    
    // Error UI Label for error messages
    let errorLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: true)
        label.text = "Error"
        label.font = UIFont.systemFont(ofSize: errorLabelHeight, weight: .light)
        return label
    }()
    
    // Sign In Button
    let signInButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button)
        button.setTitle("Sign In", for: .normal)
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        return button
    }()
    
    // Create Account Button
    let createAccountButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button)
        button.setTitle("Create an Account", for: .normal)
        button.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: Class Functions
    
    
    /**
     Function that adds all UI elements to the view and sets up all constraints for each UI element
     
     - Returns: None
     **/
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(appImageView)
        self.view.addSubview(appLabel)
        self.view.addSubview(sloganLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(errorLabel)
        self.view.addSubview(signInButton)
        self.view.addSubview(createAccountButton)
        
        appImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0).isActive = true
        appImageView.heightAnchor.constraint(equalToConstant: appImageHeight).isActive = true
        appImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        appImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        appLabel.topAnchor.constraint(equalTo: appImageView.topAnchor, constant: appImageHeight + 16.0).isActive = true
        appLabel.heightAnchor.constraint(equalToConstant: appLabelHeight).isActive = true
        appLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        appLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        sloganLabel.topAnchor.constraint(equalTo: appLabel.topAnchor, constant: appLabelHeight + 8.0).isActive = true
        sloganLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        sloganLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: sloganLabel.topAnchor, constant: sloganLabelHeight + 48.0).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: textFieldHeight + 16.0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true

        errorLabel.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: textFieldHeight + 64.0).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        signInButton.topAnchor.constraint(equalTo: errorLabel.topAnchor, constant: errorLabelHeight + 32.0).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        createAccountButton.topAnchor.constraint(equalTo: signInButton.topAnchor, constant: UIButtonHeight + 24.0).isActive = true
        createAccountButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        createAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        createAccountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        // Set background of view controller
        self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
    }
    
    
    /**
     Function that sets up controls for on screen keyboard dismissal

     - Returns: None
     **/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides the error label
        errorLabel.alpha = 0
        
        // Adds delegates to allow the removal of the onscreen keyboard
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Looks for single or multiple taps for removal of onscreen keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    /**
     Function that dismisses the onscreen keyboard
     
     - Returns: None
     **/
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    /**
     Function that dismisses the on screen keyboard after pressing the confirmation button
     
     - Parameter textField: Text Field of current cursor location
     - Returns: Bool
     **/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     Function that triggers when the Sign In button is pressed. Checks credentials and transitions to home
     
     - Returns: None
     **/
    @objc func signInTapped() {
        // Remove extraneous space characters from the textfields
        username = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Validate text fields
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            
            if error != nil {
                let errorDesc = AuthErrorCode(rawValue: error!._code)
                
                // Checks if there is text within the login fields - sets errors otherwise
                if username.count == 0 || password.count == 0 {
                    self.errorLabel.text = "Please fill in all fields"
                }
                else {
                    switch errorDesc {
                    case .wrongPassword:
                        self.errorLabel.text = "Wrong password. Please try again"
                    case .invalidEmail:
                        self.errorLabel.text = "Invalid email. Please try again"
                    case .userNotFound:
                        self.errorLabel.text = "User could not be found"
                    default:
                        self.errorLabel.text = "Unknown error"
                    }
                }
                
                // Make error label visible
                self.errorLabel.alpha = 1
            }
            else{
                // Transition to home view
                let homeViewController:HomeViewController = HomeViewController()
                homeViewController.modalPresentationStyle = .fullScreen
                self.present(homeViewController, animated: true, completion: nil)
            }
        }
    }
    
    
    /**
     Function that directs you to Create an Account - presents SignUpViewController
     
     - Returns: None
     **/
    @objc func createAccountTapped() {
        // Clear some variables related to the medication view
         medicationcount = 0
         username = ""
         password = ""
        
        // Transition to create an account view
        let signUpViewController:SignupViewController = SignupViewController()
        signUpViewController.modalPresentationStyle = .fullScreen
        self.present(signUpViewController, animated: true, completion: nil)
    }
}
