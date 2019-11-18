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

class LoginViewController: UIViewController,UITextFieldDelegate {

    let emailTextField =  CustomTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
    let passwordTextField =  CustomTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
    let errorLabel = UILabel()
    let signInButton = UIButton()
    let createAccountButton = UIButton()

    override func loadView() {
        super.loadView()
        
        // App Logo UI Image
        let appImageName = "AppLogoImage.png"
        let appImageHeight:CGFloat = 130
        let appImage = UIImage(named: appImageName)
        let appImageView = UIImageView(image: appImage!)
        appImageView.frame = CGRect(x: 0, y: 0, width: appImageHeight, height: appImageHeight)
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        appImageView.contentMode = .scaleAspectFit
        self.view.addSubview(appImageView)
        
        NSLayoutConstraint.activate([
            appImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            appImageView.heightAnchor.constraint(equalToConstant: appImageHeight),
            appImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            appImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // App UI Label
        let appLabel = UILabel()
        let appLabelHeight: CGFloat = 32
        appLabel.textColor = textColour
        appLabel.textAlignment = .center
        appLabel.text = "PARKINSENSE"
        appLabel.numberOfLines = 1
        appLabel.font = UIFont.systemFont(ofSize: appLabelHeight, weight: .light)
        appLabel.adjustsFontSizeToFitWidth = true
        appLabel.minimumScaleFactor = 0.5
        appLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(appLabel)
        
        NSLayoutConstraint.activate([
            appLabel.topAnchor.constraint(equalTo: appImageView.topAnchor, constant: appImageHeight + 16.0),
            appLabel.heightAnchor.constraint(equalToConstant: appLabelHeight),
            appLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            appLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // Slogan UI Label
        let sloganLabel = UILabel()
        let sloganLabelHeight: CGFloat = 17
        sloganLabel.textColor = textColour
        sloganLabel.textAlignment = .center
        sloganLabel.text = "SPARK YOUR SENSES"
        sloganLabel.numberOfLines = 1
        sloganLabel.font = UIFont.systemFont(ofSize: sloganLabelHeight, weight: .light)
        sloganLabel.adjustsFontSizeToFitWidth = true
        sloganLabel.minimumScaleFactor = 0.5
        sloganLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sloganLabel)
        
        NSLayoutConstraint.activate([
            sloganLabel.topAnchor.constraint(equalTo: appLabel.topAnchor, constant: appLabelHeight + 8.0),
            sloganLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            sloganLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // Email UI Textfield
        let paddingVal:CGFloat = 10
        let textFieldFontSize:CGFloat = 20
        let emailTextFieldHeight: CGFloat = textFieldFontSize + paddingVal
        emailTextField.textColor = textColour
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: textColour])
        emailTextField.paddingValue = paddingVal
        emailTextField.awakeFromNib()
        emailTextField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light)
        emailTextField.backgroundColor = .clear
        emailTextField.autocorrectionType = UITextAutocorrectionType.no
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        emailTextField.autocapitalizationType = UITextAutocapitalizationType.none
        emailTextField.returnKeyType = UIReturnKeyType.done
        emailTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        emailTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: sloganLabel.topAnchor, constant: sloganLabelHeight + 48.0),
            emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
        ])
        
        // Password UI Textfield
        let passwordTextFieldHeight: CGFloat = textFieldFontSize + paddingVal
        passwordTextField.textColor = textColour
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: textColour])
        passwordTextField.paddingValue = 10
        passwordTextField.awakeFromNib()
        passwordTextField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .clear
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.autocapitalizationType = UITextAutocapitalizationType.none
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: emailTextFieldHeight + 16.0),
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
        ])
        
        // Remember Password UI Label
        let rememberPassLabel = UILabel()
        let rememberPassLabelHeight: CGFloat = 15
        let rememberPassLabelTopPadding = passwordTextFieldHeight + rememberPassLabelHeight/3
        rememberPassLabel.textColor = textColour
        rememberPassLabel.textAlignment = .right
        rememberPassLabel.text = "Remember Password"
        rememberPassLabel.numberOfLines = 1
        rememberPassLabel.font = UIFont.systemFont(ofSize: rememberPassLabelHeight, weight: .ultraLight)
        rememberPassLabel.adjustsFontSizeToFitWidth = true
        rememberPassLabel.minimumScaleFactor = 0.5
        rememberPassLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rememberPassLabel)
        
        NSLayoutConstraint.activate([
            rememberPassLabel.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: rememberPassLabelTopPadding + 24.0),
            rememberPassLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 90.0),
        ])
        
        // Remember Password Button
        let rememberPassButton = BEMCheckBox(frame:CGRect(x: 0, y: 0, width: 25, height: 25))
        rememberPassButton.onFillColor = .blue
        rememberPassButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rememberPassButton)
        
        NSLayoutConstraint.activate([
            rememberPassButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: passwordTextFieldHeight + 24.0),
            rememberPassButton.leadingAnchor.constraint(equalTo: rememberPassLabel.trailingAnchor, constant: 16.0),
        ])
        
        // Error UI Label
        let errorLabelHeight: CGFloat = 20
        errorLabel.textColor = UIColor(red:0.97, green:0.22, blue:0.35, alpha:1.0)
        errorLabel.textAlignment = .center
        errorLabel.text = "Error"
        errorLabel.numberOfLines = 1
        errorLabel.font = UIFont.systemFont(ofSize: errorLabelHeight, weight: .light)
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.minimumScaleFactor = 0.5
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: rememberPassLabel.topAnchor, constant: rememberPassLabelTopPadding + 16.0),
            errorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            errorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])

        // Sign In Button
        let signInButtonHeight: CGFloat = 45
        signInButton.setTitleColor(buttonTextColour, for: .normal)
        signInButton.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: signInButtonHeight)
        signInButton.backgroundColor = buttonColour
        signInButton.layer.cornerRadius = 5
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        self.view.addSubview(signInButton)

        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: errorLabel.topAnchor, constant: errorLabelHeight + 32.0),
            signInButton.heightAnchor.constraint(equalToConstant: signInButtonHeight),
            signInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            signInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
        ])
        
        // Create an Account Button
        let createAccountButtonHeight: CGFloat = 45
        createAccountButton.setTitleColor(buttonTextColour, for: .normal)
        createAccountButton.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: createAccountButtonHeight)
        createAccountButton.backgroundColor = buttonColour
        createAccountButton.layer.cornerRadius = 5
        createAccountButton.setTitle("Create an Account", for: .normal)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        self.view.addSubview(createAccountButton)

        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: signInButton.topAnchor, constant: signInButtonHeight + 24.0),
            createAccountButton.heightAnchor.constraint(equalToConstant: createAccountButtonHeight),
            createAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            createAccountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set background of view controller
        self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
        
        //Hide the error label
        errorLabel.alpha = 0
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool
     {
         textField.resignFirstResponder()
         return true
     }
    
    /**
        Function about the Sign in Button, will direct you to the home page if success. If not, the error will be displayed
     
         - Parameter sender: Button itself
         - Returns: None
    **/
    @objc func signInTapped(_ sender: Any) {
        //Create cleaned versions of the text field
        username = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Validate text fields
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in

            if error != nil {
                //Could not sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
                //Transition to Home view
                let homeViewController:HomeViewController = HomeViewController()
                self.present(homeViewController, animated: true, completion: nil)
            }
        }
    }
    
    
    /**
        Function that directs you to Create an Account - presents SignUpViewController

         - Parameter sender: Button itself
         - Returns: None
    **/
    @objc func createAccountTapped(_ sender: Any) {
        let signUpViewController:SignupViewController = SignupViewController()
        self.present(signUpViewController, animated: true, completion: nil)
    }
    
}
