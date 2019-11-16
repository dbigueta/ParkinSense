//-----------------------------------------------------------------
//  File: LoginViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng
//
//  Description: Main login view of ParkinSense
//
//  Changes:
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

class LoginViewController: UIViewController {
    
//    @IBOutlet weak var usernameTextField: UITextField!
//
//    @IBOutlet weak var passwordTextField: UITextField!
//
//    @IBOutlet weak var rememberPasswordLabel: UILabel!
//
//    @IBOutlet weak var btnCheckBox: UIButton!
//
 //   @IBOutlet weak var errorLabel: UILabel!
    
//    @IBOutlet weak var signInButton: UIButton!
//
//    @IBOutlet weak var oRlabel: UILabel!
//
//    @IBOutlet weak var createAnAccountButton: UIButton!
    
    override func loadView() {
        super.loadView()
        
        // App Logo UI Image
        let appImageName = "AppLogoImage.png"
        let appImageHeight:CGFloat = 150
        let appImage = UIImage(named: appImageName)
        let appImageView = UIImageView(image: appImage!)
        appImageView.frame = CGRect(x: 0, y: 0, width: appImageHeight, height: appImageHeight)
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        appImageView.contentMode = .scaleAspectFit
        self.view.addSubview(appImageView)
        
        NSLayoutConstraint.activate([
            appImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            appImageView.heightAnchor.constraint(equalToConstant: appImageHeight),
            appImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            appImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // App UI Label
        let appLabel = UILabel()
        let appLabelHeight: CGFloat = 45
        appLabel.textAlignment = .center
        appLabel.text = "ParkinSense"
        appLabel.numberOfLines = 1
        appLabel.font = appLabel.font.withSize(appLabelHeight)
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
        let sloganLabelHeight: CGFloat = 20
        sloganLabel.textAlignment = .center
        sloganLabel.text = "Spark Your Senses"
        sloganLabel.numberOfLines = 1
        sloganLabel.font = sloganLabel.font.withSize(sloganLabelHeight)
        sloganLabel.adjustsFontSizeToFitWidth = true
        sloganLabel.minimumScaleFactor = 0.5
        sloganLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sloganLabel)
        
        NSLayoutConstraint.activate([
            sloganLabel.topAnchor.constraint(equalTo: appLabel.topAnchor, constant: appLabelHeight + 16.0),
            sloganLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            sloganLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // Email UI Textfield
        let emailTextField =  UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        let emailTextFieldHeight: CGFloat = 25
        emailTextField.placeholder = "Email"
        emailTextField.font = emailTextField.font!.withSize(emailTextFieldHeight)
        emailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        emailTextField.autocorrectionType = UITextAutocorrectionType.no
        emailTextField.keyboardType = UIKeyboardType.default
        emailTextField.returnKeyType = UIReturnKeyType.done
        emailTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        emailTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: sloganLabel.topAnchor, constant: sloganLabelHeight + 16.0),
            emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // Passowrd UI Textfield
        let passwordTextField =  UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        let passwordTextFieldHeight: CGFloat = 25
        passwordTextField.placeholder = "Password"
        passwordTextField.font = emailTextField.font!.withSize(passwordTextFieldHeight)
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: passwordTextFieldHeight + 16.0),
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // Remember Password UI Label
        let rememberPassLabel = UILabel()
        let rememberPassLabelHeight: CGFloat = 15
        let rememberPassLabelTopPadding = passwordTextFieldHeight + rememberPassLabelHeight/2
        rememberPassLabel.textAlignment = .right
        rememberPassLabel.text = "Remember Password"
        rememberPassLabel.numberOfLines = 1
        rememberPassLabel.font = rememberPassLabel.font.withSize(rememberPassLabelHeight)
        rememberPassLabel.adjustsFontSizeToFitWidth = true
        rememberPassLabel.minimumScaleFactor = 0.5
        rememberPassLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rememberPassLabel)
        
        NSLayoutConstraint.activate([
            rememberPassLabel.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: rememberPassLabelTopPadding + 16.0),
            rememberPassLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80.0),
        ])
        
        // Remember Password Button
        let rememberPassButton = BEMCheckBox(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        rememberPassButton.onFillColor = .blue
        rememberPassButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rememberPassButton)
        
        NSLayoutConstraint.activate([
            rememberPassButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: passwordTextFieldHeight + 16.0),
            rememberPassButton.leadingAnchor.constraint(equalTo: rememberPassLabel.trailingAnchor, constant: 16.0),
        ])
        
        // Error UI Label
        let errorLabel = UILabel()
        let errorLabelHeight: CGFloat = 20
        errorLabel.textAlignment = .center
        errorLabel.text = "Error"
        errorLabel.numberOfLines = 1
        errorLabel.font = sloganLabel.font.withSize(errorLabelHeight)
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
        let signInButton = UIButton()
        let signInButtonHeight: CGFloat = 50
        signInButton.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: signInButtonHeight)
        signInButton.backgroundColor = UIColor.red
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(signInButton)

        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: errorLabel.topAnchor, constant: errorLabelHeight + 16.0),
            signInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            signInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // OR UI Label
        let orLabel = UILabel()
        let orLabelHeight: CGFloat = 20
        orLabel.textAlignment = .center
        orLabel.text = "OR"
        orLabel.numberOfLines = 1
        orLabel.font = orLabel.font.withSize(orLabelHeight)
        orLabel.adjustsFontSizeToFitWidth = true
        orLabel.minimumScaleFactor = 0.5
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(orLabel)
        
        NSLayoutConstraint.activate([
            orLabel.topAnchor.constraint(equalTo: signInButton.topAnchor, constant: signInButtonHeight + 16.0),
            orLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            orLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // Create an Account Button
        let createAccountButton = UIButton()
        let createAccountButtonHeight: CGFloat = 50
        createAccountButton.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: createAccountButtonHeight)
        createAccountButton.backgroundColor = UIColor.red
        createAccountButton.setTitle("Create an Account", for: .normal)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(createAccountButton)

        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: orLabel.topAnchor, constant: orLabelHeight + 16.0),
            createAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            createAccountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
    }
    
    @objc func buttonAction(sender: UIButton!) {
       print("Button tapped")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
        //btnCheckBox.setImage(UIImage(named:"uncheckbox"), for: .normal)
        //btnCheckBox.setImage(UIImage(named:"checkbox"), for: .selected)
    }
    
    
    /**
        Function to set up the default ErrorLabel invisiable and set up the button and text appearance
     
         - Returns: None
    **/
    func setUpElements(){
        
        //Hide the error label
        //errorLabel.alpha = 0
        
        //Style the elements 
//        Utilities.styleTextField(usernameTextField)
//
//        Utilities.styleTextField(passwordTextField)
//
//        Utilities.styleFilledButton(signInButton)
//
//        Utilities.styleFilledButton(createAnAccountButton)
    }
    

//    /**
//        Function about the Remember Password Button check or uncheck
//
//         - Parameter sender: Button itself
//         - Returns: None
//    **/
//    @IBAction func checkMarkTapped(_ sender: UIButton) {
//
//        UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
//            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//
//        }) { (success) in
//            UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
//                sender.isSelected = !sender.isSelected
//                sender.transform = .identity
//            }, completion: nil)
//        }
//
//    }
    
    
    /**
        Function about the Sign in Button, will direct you to the home page if success. If not, the error will be displayed
     
         - Parameter sender: Button itself
         - Returns: None
    **/
    @IBAction func signInTapped(_ sender: Any) {
        
        //validate Text Fields
        
        //Create cleaned versions of the text field
//        username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
//        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
//
//            if error != nil {
//                //could not sign in
//                self.errorLabel.text = error!.localizedDescription
//                self.errorLabel.alpha = 1
//            }
//            else{
//
//                self.performSegue(withIdentifier: "loginToHomeID", sender: nil)
//
//            }
//        }
        
    }
    
    
//    /**
//        Function that directs you to Create an Account
//
//         - Parameter sender: Button itself
//         - Returns: None
//    **/
//    @IBAction func createAccountTapped(_ sender: Any) {
//    }
    
    
//    /**
//        Function to go back to Login
//
//         - Parameter sender: Button itself
//         - Returns: None
//
//    **/
//    @IBAction func unwindToLogin(segue: UIStoryboardSegue){
//
//    }
    
}
