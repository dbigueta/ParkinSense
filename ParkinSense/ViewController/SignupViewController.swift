//-----------------------------------------------------------------
//  File: SignupViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng, Hamlet Jiang Su
//
//  Description: Main view of the signup page - allows registration of new users
//
//  Changes:
//      - Refactored code to programmatically code UI elements
//      - Save and update the login time in Firebase
//
//  Known Bugs:
//      - Need to read the medication time to display in the screen 
//
//-----------------------------------------------------------------

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    let emailTextField =  CustomTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
    let passwordTextField =  CustomTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
    let confirmPasswordTextField =  CustomTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
    
    let errorLabel = UILabel()
    let medicationLabel = UILabel()
    
    let createAnAccountButton = UIButton()
    let addNewMedicationDetailButton = UIButton()
    let alreadyHaveAnAccountButton = UIButton()
    
    let textColour = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
    let buttonTextColour = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
    let buttonColour = UIColor(red:0.75, green:0.85, blue:0.84, alpha:1.0)
    let font = UIFont.systemFont(ofSize: 20, weight: .light)
    
    let createAnAccountButtonHeight: CGFloat = 45
    let alreadyHaveAnAccountButtonHeight: CGFloat = 45
    let addNewMedicationDetailButtonHeight: CGFloat = 45
    
    override func loadView() {
        super.loadView()
        
        // App Logo UI Image
        let appImageName = "AppLogoImage.png"
        let appImageHeight:CGFloat = 50
        let appImage = UIImage(named: appImageName)
        let appImageView = UIImageView(image: appImage!)
        appImageView.frame = CGRect(x: 0, y: 0, width: appImageHeight, height: appImageHeight)
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        appImageView.contentMode = .scaleAspectFit
        self.view.addSubview(appImageView)
        
        NSLayoutConstraint.activate([
            appImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            appImageView.heightAnchor.constraint(equalToConstant: appImageHeight),
            appImageView.widthAnchor.constraint(equalToConstant: appImageHeight),
            appImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
        ])
        
        // Create an Account UI Label
        let createAccountLabel = UILabel()
        let createAccountLabelHeight: CGFloat = 17
        createAccountLabel.textColor = textColour
        createAccountLabel.textAlignment = .center
        createAccountLabel.text = "CREATE AN ACCOUNT"
        createAccountLabel.numberOfLines = 1
        createAccountLabel.font = UIFont.systemFont(ofSize: createAccountLabelHeight, weight: .medium)
        createAccountLabel.adjustsFontSizeToFitWidth = true
        createAccountLabel.minimumScaleFactor = 0.5
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(createAccountLabel)

        NSLayoutConstraint.activate([
            createAccountLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            createAccountLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: appImageHeight + 32.0),
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
            emailTextField.topAnchor.constraint(equalTo: createAccountLabel.topAnchor, constant: createAccountLabelHeight + 48.0),
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
        
        // Confirm Password UI Textfield
        let confirmPasswordTextFieldHeight: CGFloat = textFieldFontSize + paddingVal
        confirmPasswordTextField.textColor = textColour
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: textColour])
        confirmPasswordTextField.paddingValue = 10
        confirmPasswordTextField.awakeFromNib()
        confirmPasswordTextField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light)
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.backgroundColor = .clear
        confirmPasswordTextField.autocorrectionType = UITextAutocorrectionType.no
        confirmPasswordTextField.autocapitalizationType = UITextAutocapitalizationType.none
        confirmPasswordTextField.keyboardType = UIKeyboardType.default
        confirmPasswordTextField.returnKeyType = UIReturnKeyType.done
        confirmPasswordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        confirmPasswordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(confirmPasswordTextField)

        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: passwordTextFieldHeight + 16.0),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
        ])

        // Medication UI Label
        let medicationLabelHeight: CGFloat = 20
        medicationLabel.textColor = UIColor(red:0.97, green:0.22, blue:0.35, alpha:1.0)
        medicationLabel.textAlignment = .center
        medicationLabel.text = "Medication"
        medicationLabel.numberOfLines = 1
        medicationLabel.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light)
        medicationLabel.adjustsFontSizeToFitWidth = true
        medicationLabel.minimumScaleFactor = 0.5
        medicationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(medicationLabel)

        NSLayoutConstraint.activate([
            medicationLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.topAnchor, constant: confirmPasswordTextFieldHeight + 16.0),
            medicationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            medicationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
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
            errorLabel.topAnchor.constraint(equalTo: medicationLabel.topAnchor, constant: medicationLabelHeight + 16.0),
            errorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            errorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])

         // Already Have Account Button
         alreadyHaveAnAccountButton.setTitleColor(buttonTextColour, for: .normal)
         alreadyHaveAnAccountButton.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: alreadyHaveAnAccountButtonHeight)
         alreadyHaveAnAccountButton.backgroundColor = buttonColour
         alreadyHaveAnAccountButton.layer.cornerRadius = 5
         alreadyHaveAnAccountButton.setTitle("Already have an account? Sign in", for: .normal)
         alreadyHaveAnAccountButton.translatesAutoresizingMaskIntoConstraints = false
         alreadyHaveAnAccountButton.addTarget(self, action: #selector(alreadyHaveAnAccountTapped), for: .touchUpInside)
         self.view.addSubview(alreadyHaveAnAccountButton)

         NSLayoutConstraint.activate([
             alreadyHaveAnAccountButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32.0),
             alreadyHaveAnAccountButton.heightAnchor.constraint(equalToConstant: addNewMedicationDetailButtonHeight),
             alreadyHaveAnAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
             alreadyHaveAnAccountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
         ])
        
        // Create Account Button
         createAnAccountButton.setTitleColor(buttonTextColour, for: .normal)
         createAnAccountButton.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: createAnAccountButtonHeight)
         createAnAccountButton.backgroundColor = buttonColour
         createAnAccountButton.layer.cornerRadius = 5
         createAnAccountButton.setTitle("Create an Account", for: .normal)
         createAnAccountButton.translatesAutoresizingMaskIntoConstraints = false
         createAnAccountButton.addTarget(self, action: #selector(createAnAccountTapped), for: .touchUpInside)
         self.view.addSubview(createAnAccountButton)

         NSLayoutConstraint.activate([
             createAnAccountButton.bottomAnchor.constraint(equalTo: alreadyHaveAnAccountButton.bottomAnchor, constant: 0 - alreadyHaveAnAccountButtonHeight - 16.0),
             createAnAccountButton.heightAnchor.constraint(equalToConstant: createAnAccountButtonHeight),
             createAnAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
             createAnAccountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
         ])
        
        // Add Medication Button
        addNewMedicationDetailButton.setTitleColor(buttonTextColour, for: .normal)
        addNewMedicationDetailButton.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: addNewMedicationDetailButtonHeight)
        addNewMedicationDetailButton.backgroundColor = buttonColour
        addNewMedicationDetailButton.layer.cornerRadius = 5
        addNewMedicationDetailButton.setTitle("Add New Medication Detail", for: .normal)
        addNewMedicationDetailButton.translatesAutoresizingMaskIntoConstraints = false
        addNewMedicationDetailButton.addTarget(self, action: #selector(addNewMedicationDetailTapped), for: .touchUpInside)
        self.view.addSubview(addNewMedicationDetailButton)

        NSLayoutConstraint.activate([
            addNewMedicationDetailButton.bottomAnchor.constraint(equalTo: createAnAccountButton.bottomAnchor, constant: 0 - createAnAccountButtonHeight - 16.0),
            addNewMedicationDetailButton.heightAnchor.constraint(equalToConstant: addNewMedicationDetailButtonHeight),
            addNewMedicationDetailButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            addNewMedicationDetailButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Notifies view controller to perform an update
        NotificationCenter.default.addObserver(self, selector: #selector(self.setUpElement), name: NSNotification.Name(rawValue: "DoUpdateLabel"), object: nil)
        
        //Set background colour of view controller
        self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setUpElement()
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
     Function to set up the default ErrorLabel to be invisible and set up medication, email, and password labels
     
     - Returns: No
     **/
    @objc func setUpElement(){
        
        //Hide the error label, medication label and save the Username and Password
        errorLabel.alpha = 0
        
        medicationLabel.alpha = CGFloat(medicationLabelAlpha)
        medicationLabel.text = medicationName
        
        emailTextField.text = username
        passwordTextField.text = password
        
    }
    
    
    /**
     Function to get the error message from text field for username and password
     
     - Returns: String
     **/
    func validateFields() -> String? {
        //Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
            
        }
        
        //check the password match the confirm password
        if passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines){
            
            return "Passwords do not match. Please re-enter your password."
        }
        
        return nil
        
    }
    
    
    /**
     Function to create a new account. Will log in and move to home page if signup was successful
     
     - Parameter sender: Button itself
     - Returns: None
     **/
    @IBAction func createAnAccountTapped(_ sender: Any) {
        
        //Validate the fields
        let error = validateFields()
        
        if error != nil{
            
            //There's something wrong with the fields, show error message
            showError(error!)
        }
        else{
            //Create cleaned versions of the data
            username = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: username, password: password) { (result, err) in
                
                //Check for errors
                if err != nil {
                    if password.count < 6{
                        self.showError("Password must be at least 6 characters")
                    }
                        //There was an error creating the user
                    else{
                        self.showError("User Account should be valid email address")
                    }
                }
                else
                {
                    //User was created successfully, now store the username
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.uid).setData(["Username": username, "uid": result!.user.uid, "MedicationName": medicationName, "login_time":rightNow - 3600*24, "Game_One_lastMaxScore":0]) { (error) in
                        
                        if error != nil {
                            //Show error message
                            self.showError("Error saving user data")
                        }
                    }
        
                    //Transition to the home screen
                    let homeViewController:HomeViewController = HomeViewController()
                    self.present(homeViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    /**
     Function to Add New Medication, will direct you to Medication Detail Page, and save the username and password into constant which later on when you go back to the page, the username and password will still remain in the sign up page
     
     - Parameter sender: Button itself
     - Returns: None
     **/
    @objc func addNewMedicationDetailTapped(_ sender: Any) {
        username = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let medicationViewController:MedicationDetailViewController = MedicationDetailViewController()
        self.present(medicationViewController, animated: true, completion: nil)
    }
    
    
    /**
     Function that will lead you back to login page if button is pressed
     
     - Parameter sender: Self Button
     - Returns: None
     **/
    @objc func alreadyHaveAnAccountTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /**
     Function will show any errors that may have occurred
     
     - Parameter sender: Button itself
     - Returns: None
     **/
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
