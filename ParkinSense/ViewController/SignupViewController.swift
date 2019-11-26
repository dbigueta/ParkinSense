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
    
    // App Logo UI Image
    let appImageView: UIImageView = {
        let imageView = UIImageView(image: appImage!)
        Utilities.styleImageView(imageView)
        return imageView
    }()
    
    // Create an account UI Label for header
    let createAccountLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "CREATE AN ACCOUNT"
        label.font = UIFont.systemFont(ofSize: headerLabelHeight, weight: .medium)
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
    
    // Confirm Password UI Textfield to input password
    let confirmPasswordTextField: CustomTextField = {
        let textField = CustomTextField()
        Utilities.styleTextField(textField, password: true)
        textField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: textColour])
        textField.paddingValue = paddingVal
        textField.awakeFromNib()
        textField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light)
        textField.keyboardType = UIKeyboardType.default
        return textField
    }()
    
    // Medication UI Label
    let medicationLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "Medication"
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light)
        return label
    }()
    
    // Error UI Label for error messages
    let errorLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: true)
        label.text = "Error"
        label.font = UIFont.systemFont(ofSize: errorLabelHeight, weight: .light)
        return label
    }()
    
    // Already have an account Button
    let alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button)
        button.setTitle("Already have an account? Sign in", for: .normal)
        button.addTarget(self, action: #selector(alreadyHaveAnAccountTapped), for: .touchUpInside)
        return button
    }()
    
    // Create an account Button
    let createAnAccountButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button)
        button.setTitle("Create an Account", for: .normal)
        button.addTarget(self, action: #selector(createAnAccountTapped), for: .touchUpInside)
        return button
    }()
    
    // Add new medication Button
    let addNewMedicationDetailButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button)
        button.setTitle("Add New Medication Detail", for: .normal)
        button.addTarget(self, action: #selector(addNewMedicationDetailTapped), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(appImageView)
        self.view.addSubview(createAccountLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(confirmPasswordTextField)
        self.view.addSubview(medicationLabel)
        self.view.addSubview(errorLabel)
        self.view.addSubview(alreadyHaveAnAccountButton)
        self.view.addSubview(createAnAccountButton)
        self.view.addSubview(addNewMedicationDetailButton)
        
        appImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        appImageView.heightAnchor.constraint(equalToConstant: appImageHeight).isActive = true
        appImageView.widthAnchor.constraint(equalToConstant: appImageHeight).isActive = true
        appImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        
        createAccountLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0).isActive = true
        createAccountLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: appImageHeight + 32.0).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: createAccountLabel.topAnchor, constant: headerLabelHeight + 48.0).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: textFieldHeight + 16.0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: textFieldHeight + 16.0).isActive = true
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        confirmPasswordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        medicationLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.topAnchor, constant: textFieldHeight + 16.0).isActive = true
        medicationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        medicationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        errorLabel.topAnchor.constraint(equalTo: medicationLabel.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        alreadyHaveAnAccountButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32.0).isActive = true
        alreadyHaveAnAccountButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        alreadyHaveAnAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        alreadyHaveAnAccountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        createAnAccountButton.bottomAnchor.constraint(equalTo: alreadyHaveAnAccountButton.bottomAnchor, constant: 0 - UIButtonHeight - 16.0).isActive = true
        createAnAccountButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        createAnAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        createAnAccountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        addNewMedicationDetailButton.bottomAnchor.constraint(equalTo: createAnAccountButton.bottomAnchor, constant: 0 - UIButtonHeight - 16.0).isActive = true
        addNewMedicationDetailButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        addNewMedicationDetailButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        addNewMedicationDetailButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
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
    @objc func createAnAccountTapped(_ sender: Any) {
        
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
