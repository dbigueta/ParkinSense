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
        let imageView = UIImageView(image: appImage!)   // Creates view for image
        Utilities.styleImageView(imageView)             // Styles to view
        return imageView
    }()
    
    // App UI Label for "PARKINSENSE"
    let appLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Style label
        label.text = "PARKINSENSE"  // Set label text
        label.font = UIFont.systemFont(ofSize: appLabelHeight, weight: .light)  // Set label font
        return label
    }()
    
    // Slogan UI Label for "SPARK YOUR SENSES"
    let sloganLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Style label
        label.text = "SPARK YOUR SENSES" // Set label text
        label.font = UIFont.systemFont(ofSize: sloganLabelHeight, weight: .light) // Set label font
        return label
    }()
    
    // Email UI Textfield to input email address
    let emailTextField: CustomTextField = {
        let textField = CustomTextField()
        Utilities.styleTextField(textField, password: false) // Style text field
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: textColour]) // Set the placeholder text and colour
        textField.paddingValue = paddingVal // Set padding to the text field
        textField.awakeFromNib()
        textField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light) // Set textfield font
        textField.keyboardType = UIKeyboardType.emailAddress // Set textfield keyboard type
        return textField
    }()
    
    // Password UI Textfield to input password
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        Utilities.styleTextField(textField, password: true) // Style text field
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: textColour]) // Set the placeholder text and colour
        textField.paddingValue = paddingVal // Set padding to the text field
        textField.awakeFromNib()
        textField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light) // Set textfield font
        textField.keyboardType = UIKeyboardType.default // Set textfield keyboard type
        return textField
    }()
    
    // Error UI Label for error messages
    let errorLabel: UILabel = {
        let label = UILabel() // Create label
        Utilities.styleUILabel(label, error: true) // Style label
        label.text = "Error" // Set label text
        label.font = UIFont.systemFont(ofSize: errorLabelHeight, weight: .light) // Set label font
        return label
    }()
    
    // Sign In Button
    let signInButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button) // Style button
        button.setTitle("Sign In", for: .normal) // Set button label
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside) // Set function to trigger when tapped
        return button
    }()
    
    // Create Account Button
    let createAccountButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button) // Style button
        button.setTitle("Create an Account", for: .normal) // Set button label
        button.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside) // Set function to trigger when tapped
        return button
    }()
    
    
    // MARK: Class Functions
    
    
    /**
     Function that adds all UI elements to the view and sets up all constraints for each UI element
     
     - Returns: None
     **/
    override func loadView() {
        super.loadView()
        
        // Adds each view, label, textfield and button into the current screen
        self.view.addSubview(appImageView)
        self.view.addSubview(appLabel)
        self.view.addSubview(sloganLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(errorLabel)
        self.view.addSubview(signInButton)
        self.view.addSubview(createAccountButton)
        
        // Set App Image constraints to allow for multiple device configurations
        appImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0).isActive = true
        appImageView.heightAnchor.constraint(equalToConstant: appImageHeight).isActive = true
        appImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        appImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        // Set App Name constraints to allow for multiple device configurations
        appLabel.topAnchor.constraint(equalTo: appImageView.topAnchor, constant: appImageHeight + 16.0).isActive = true
        appLabel.heightAnchor.constraint(equalToConstant: appLabelHeight).isActive = true
        appLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        appLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        // Set App Slogan constraints to allow for multiple device configurations
        sloganLabel.topAnchor.constraint(equalTo: appLabel.topAnchor, constant: appLabelHeight + 8.0).isActive = true
        sloganLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        sloganLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        // Set email text field constraints to allow for multiple device configurations
        emailTextField.topAnchor.constraint(equalTo: sloganLabel.topAnchor, constant: sloganLabelHeight + 48.0).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        // Set password text field constraints to allow for multiple device configurations
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: textFieldHeight + 16.0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true

        // Set error label constraints to allow for multiple device configurations
        errorLabel.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: textFieldHeight + 64.0).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        // Set sign in button constraints to allow for multiple device configurations
        signInButton.topAnchor.constraint(equalTo: errorLabel.topAnchor, constant: errorLabelHeight + 32.0).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        // Set create account button constraints to allow for multiple device configurations
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
     Function that removes username and password from login screen once we sign out

     - Returns: None
     **/
    override func viewWillAppear(_ animated: Bool) {
        // Set error label to be hidden and remove email and password from login
        errorLabel.alpha = 0
        emailTextField.text = ""
        passwordTextField.text = ""
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
                    // Sets error messages depending on error
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
                homeViewController.modalPresentationStyle = .fullScreen // Set view style to fullscreen
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
        signUpViewController.modalPresentationStyle = .fullScreen // Set view style to fullscreen
        self.present(signUpViewController, animated: true, completion: nil)
    }
}
