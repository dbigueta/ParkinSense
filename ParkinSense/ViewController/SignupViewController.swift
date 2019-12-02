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
    // MARK: Class Variables
    
    // App Logo UI Image
    let appImageView: UIImageView = {
        let imageView = UIImageView(image: appImage!)
        Utilities.styleImageView(imageView) // Styles image
        return imageView
    }()
    
    // Create an account UI Label for header
    let createAccountLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "CREATE AN ACCOUNT" // Label text
        label.font = UIFont.systemFont(ofSize: headerLabelHeight, weight: .medium) // Set font size
        return label
    }()
    
    // Email UI Textfield to input email address
    let emailTextField: CustomTextField = {
        let textField = CustomTextField()
        Utilities.styleTextField(textField, password: false) // Style text field
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: textColour]) // Set placeholder text and colour
        textField.paddingValue = paddingVal // Set text field padding
        textField.awakeFromNib()
        textField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light) // Set font size
        textField.keyboardType = UIKeyboardType.emailAddress // Set textfield keyboard type
        return textField
    }()
    
    // Password UI Textfield to input password
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        Utilities.styleTextField(textField, password: true) // Style text field
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: textColour]) // Set placeholder text and colour
        textField.paddingValue = paddingVal // Set text field padding
        textField.awakeFromNib()
        textField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light) // Set font size
        textField.keyboardType = UIKeyboardType.default // Set textfield keyboard type
        return textField
    }()
    
    // Confirm Password UI Textfield to input password
    let confirmPasswordTextField: CustomTextField = {
        let textField = CustomTextField()
        Utilities.styleTextField(textField, password: true) // Style text field
        textField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: textColour])
        textField.paddingValue = paddingVal
        textField.awakeFromNib()
        textField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light) // Set font size
        textField.keyboardType = UIKeyboardType.default // Set textfield keyboard type
        return textField
    }()
    
    // Medication UI Label
    let medicationLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .left // Set text alignment
        return label
    }()
    
    // Medication UI Label
    let medicationLabel1: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .left // Set text alignment
        return label
    }()
    
    // Medication UI Label
    let medicationLabel2: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .left // Set text alignment
        return label
    }()
    
    // Medication UI Label
    let medicationLabel3: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .left // Set text alignment
        return label
    }()
    
    // Medication UI Label
    let medicationLabel4: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .left // Set text alignment
        return label
    }()
    
    // Medication Days UI Label
    let medicationLabelDate: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Date" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .left // Set text alignment
        return label
    }()
    
    // Medication Days UI Label
    let medicationLabelDate1: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Date" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .left // Set text alignment
        return label
    }()
    
    // Medication Days UI Label
    let medicationLabelDate2: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Date" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .left // Set text alignment
        return label
    }()
    
    // Medication Days UI Label
    let medicationLabelDate3: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Date" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .left // Set text alignment
        return label
    }()
    
    // Medication Days UI Label
    let medicationLabelDate4: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Date" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .left // Set text alignment
        return label
    }()
    
    // Medication Time UI Label
    let medicationLabelTime: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Time" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .right // Set text alignment
        return label
    }()
    
    // Medication Time UI Label
    let medicationLabelTime1: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Time" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .right // Set text alignment
        return label
    }()
    
    // Medication Time UI Label
    let medicationLabelTime2: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Time" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .right // Set text alignment
        return label
    }()
    
    // Medication Time UI Label
    let medicationLabelTime3: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Time" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .right // Set text alignment
        return label
    }()
    
    // Medication Time UI Label
    let medicationLabelTime4: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Time" // Label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .light) // Set font size
        label.textAlignment = .right // Set text alignment
        return label
    }()
    
    // Error UI Label for error messages
    let errorLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: true) // Styles label
        label.text = "Error" // Label text
        label.font = UIFont.systemFont(ofSize: errorLabelHeight, weight: .light) // Set font size
        
        return label
    }()
    
    // Already have an account Button
    let alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button) // Style button
        button.setTitle("Already have an account? Sign in", for: .normal) // Set button label
        button.addTarget(self, action: #selector(alreadyHaveAnAccountTapped), for: .touchUpInside) // Set function to trigger when tapped
        return button
    }()
    
    // Create an account Button
    let createAnAccountButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button) // Style button
        button.setTitle("Create an Account", for: .normal) // Set button label
        button.addTarget(self, action: #selector(createAnAccountTapped), for: .touchUpInside) // Set function to trigger when tapped
        return button
    }()
    
    // Add new medication Button
    let addNewMedicationDetailButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button) // Style button
        button.setTitle("Add New Medication Detail", for: .normal) // Set button label
        button.addTarget(self, action: #selector(addNewMedicationDetailTapped), for: .touchUpInside) // Set function to trigger when tapped
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
        self.view.addSubview(createAccountLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(confirmPasswordTextField)
        self.view.addSubview(medicationLabel)
        self.view.addSubview(medicationLabelDate)
        self.view.addSubview(medicationLabelTime)
        self.view.addSubview(medicationLabel1)
        self.view.addSubview(medicationLabelDate1)
        self.view.addSubview(medicationLabelTime1)
        self.view.addSubview(medicationLabel2)
        self.view.addSubview(medicationLabelDate2)
        self.view.addSubview(medicationLabelTime2)
        self.view.addSubview(medicationLabel3)
        self.view.addSubview(medicationLabelDate3)
        self.view.addSubview(medicationLabelTime3)
        self.view.addSubview(medicationLabel4)
        self.view.addSubview(medicationLabelDate4)
        self.view.addSubview(medicationLabelTime4)
        self.view.addSubview(errorLabel)
        self.view.addSubview(alreadyHaveAnAccountButton)
        self.view.addSubview(createAnAccountButton)
        self.view.addSubview(addNewMedicationDetailButton)
        
         // Set App Image constraints to allow for multiple device configurations
        appImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        appImageView.heightAnchor.constraint(equalToConstant: appImageHeaderHeight).isActive = true
        appImageView.widthAnchor.constraint(equalToConstant: appImageHeaderHeight).isActive = true
        appImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        
         // Set Header text constraints to allow for multiple device configurations
        createAccountLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0).isActive = true
        createAccountLabel.leadingAnchor.constraint(equalTo: appImageView.leadingAnchor, constant: appImageHeaderHeight + 32.0).isActive = true
        
         // Set email textfield constraints to allow for multiple device configurations
        emailTextField.topAnchor.constraint(equalTo: createAccountLabel.topAnchor, constant: headerLabelHeight + 32.0).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        // Set password textfield constraints to allow for multiple device configurations
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: textFieldHeight + 16.0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        // Set confirm password textfield constraints to allow for multiple device configurations
        confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: textFieldHeight + 16.0).isActive = true
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        confirmPasswordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        // Set medication header constraints to allow for multiple device configurations
        medicationLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.topAnchor, constant: textFieldHeight + 24.0).isActive = true
        medicationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        medicationLabel.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
        // Set medication date header constraints to allow for multiple device configurations
        medicationLabelDate.topAnchor.constraint(equalTo: confirmPasswordTextField.topAnchor, constant: textFieldHeight + 24.0).isActive = true
        medicationLabelDate.leadingAnchor.constraint(equalTo: medicationLabel.leadingAnchor, constant: medicationLabelWidth).isActive = true
        medicationLabelDate.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication time header constraints to allow for multiple device configurations
        medicationLabelTime.topAnchor.constraint(equalTo: confirmPasswordTextField.topAnchor, constant: textFieldHeight + 24.0).isActive = true
        medicationLabelTime.leadingAnchor.constraint(equalTo: medicationLabelDate.leadingAnchor, constant: medicationLabelWidth).isActive = true
        medicationLabelTime.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
        // Set medication constraints to allow for multiple device configurations
        medicationLabel1.topAnchor.constraint(equalTo: medicationLabel.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabel1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        medicationLabel1.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication date constraints to allow for multiple device configurations
        medicationLabelDate1.topAnchor.constraint(equalTo: medicationLabel.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabelDate1.leadingAnchor.constraint(equalTo: medicationLabel1.leadingAnchor, constant: medicationLabelWidth).isActive = true
        medicationLabelDate1.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication time constraints to allow for multiple device configurations
        medicationLabelTime1.topAnchor.constraint(equalTo: medicationLabel.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabelTime1.leadingAnchor.constraint(equalTo: medicationLabelDate1.leadingAnchor, constant: medicationLabelWidth).isActive = true
        medicationLabelTime1.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication constraints to allow for multiple device configurations
        medicationLabel2.topAnchor.constraint(equalTo: medicationLabel1.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabel2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        medicationLabel2.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication date constraints to allow for multiple device configurations
        medicationLabelDate2.topAnchor.constraint(equalTo: medicationLabel1.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabelDate2.leadingAnchor.constraint(equalTo: medicationLabel2.leadingAnchor, constant: medicationLabelWidth).isActive = true
        medicationLabelDate2.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication time constraints to allow for multiple device configurations
        medicationLabelTime2.topAnchor.constraint(equalTo: medicationLabel1.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabelTime2.leadingAnchor.constraint(equalTo: medicationLabelDate2.leadingAnchor, constant: medicationLabelWidth).isActive = true
        medicationLabelTime2.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication constraints to allow for multiple device configurations
        medicationLabel3.topAnchor.constraint(equalTo: medicationLabel2.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabel3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        medicationLabel3.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication date constraints to allow for multiple device configurations
        medicationLabelDate3.topAnchor.constraint(equalTo: medicationLabel2.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabelDate3.leadingAnchor.constraint(equalTo: medicationLabel3.leadingAnchor, constant: medicationLabelWidth).isActive = true
        medicationLabelDate3.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication time constraints to allow for multiple device configurations
        medicationLabelTime3.topAnchor.constraint(equalTo: medicationLabel2.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabelTime3.leadingAnchor.constraint(equalTo: medicationLabelDate3.leadingAnchor, constant: medicationLabelWidth).isActive = true
        medicationLabelTime3.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication constraints to allow for multiple device configurations
        medicationLabel4.topAnchor.constraint(equalTo: medicationLabel3.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabel4.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        medicationLabel4.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication constraints to allow for multiple device configurations
        medicationLabelDate4.topAnchor.constraint(equalTo: medicationLabel3.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabelDate4.leadingAnchor.constraint(equalTo: medicationLabel4.leadingAnchor, constant: medicationLabelWidth).isActive = true
        medicationLabelDate4.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set medication time constraints to allow for multiple device configurations
        medicationLabelTime4.topAnchor.constraint(equalTo: medicationLabel3.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationLabelTime4.leadingAnchor.constraint(equalTo: medicationLabelDate4.leadingAnchor, constant: medicationLabelWidth).isActive = true
        medicationLabelTime4.widthAnchor.constraint(equalToConstant: medicationLabelWidth).isActive = true
        
         // Set error label constraints to allow for multiple device configurations
        errorLabel.topAnchor.constraint(equalTo: medicationLabel4.topAnchor, constant: medicationLabelHeight + 24.0).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
         // Set back button constraints to allow for multiple device configurations
        alreadyHaveAnAccountButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32.0).isActive = true
        alreadyHaveAnAccountButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        alreadyHaveAnAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        alreadyHaveAnAccountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
         // Set create account button constraints to allow for multiple device configurations
        createAnAccountButton.bottomAnchor.constraint(equalTo: alreadyHaveAnAccountButton.bottomAnchor, constant: 0 - UIButtonHeight - 16.0).isActive = true
        createAnAccountButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        createAnAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        createAnAccountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
         // Set medication detail button constraints to allow for multiple device configurations
        addNewMedicationDetailButton.bottomAnchor.constraint(equalTo: createAnAccountButton.bottomAnchor, constant: 0 - UIButtonHeight - 16.0).isActive = true
        addNewMedicationDetailButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        addNewMedicationDetailButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        addNewMedicationDetailButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
    }
    
    
    /**
     Function that sets up controls for on screen keyboard dismissal
     
     - Returns: None
     **/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notifies view controller to perform an update to update medication labels
        NotificationCenter.default.addObserver(self, selector: #selector(self.setUpElement), name: NSNotification.Name(rawValue: "DoUpdateLabel"), object: nil)
        
        // Set background colour of view controller
        self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
        
        // Adds delegates to allow the removal of the onscreen keyboard
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        // Looks for single or multiple taps for removal of onscreen keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setUpElement()
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
     Function that sets up the alpha labels for error and medication details to be hidden unless there is some actual information
     
     - Returns: None
     **/
    @objc func setUpElement(){
        // Hide the error label
        errorLabel.alpha = 0
        
        // Hides UI elements of the first medication
        medicationLabel.alpha = CGFloat(medicationLabelAlpha)
        medicationLabelTime.alpha = CGFloat(medicationLabelAlpha)
        medicationLabelDate.alpha = CGFloat(medicationLabelAlpha)
        
        // Sets text for the first medication
        medicationLabel.text = medicationName
        medicationLabelTime.text = medicationTime
        medicationLabelDate.text = medicationDate
        
        // Hides UI elements of the second medication
        medicationLabel1.alpha = CGFloat(medicationLabel1Alpha)
        medicationLabelTime1.alpha = CGFloat(medicationLabel1Alpha)
        medicationLabelDate1.alpha = CGFloat(medicationLabel1Alpha)
        
        // Sets text for the second medication
        medicationLabel1.text = medicationName1
        medicationLabelTime1.text = medicationTime1
        medicationLabelDate1.text = medicationDate1
        
        // Hides UI elements of the third medication
        medicationLabel2.alpha = CGFloat(medicationLabel2Alpha)
        medicationLabelTime2.alpha = CGFloat(medicationLabel2Alpha)
        medicationLabelDate2.alpha = CGFloat(medicationLabel2Alpha)
        
        // Sets text for the third medication
        medicationLabel2.text = medicationName2
        medicationLabelTime2.text = medicationTime2
        medicationLabelDate2.text = medicationDate2
        
        // Hides UI elements of the fourth medication
        medicationLabel3.alpha = CGFloat(medicationLabel3Alpha)
        medicationLabelTime3.alpha = CGFloat(medicationLabel3Alpha)
        medicationLabelDate3.alpha = CGFloat(medicationLabel3Alpha)
        
        // Sets text for the fourth medication
        medicationLabel3.text = medicationName3
        medicationLabelTime3.text = medicationTime3
        medicationLabelDate3.text = medicationDate3
        
        // Hides UI elements of the fifth medication
        medicationLabel4.alpha = CGFloat(medicationLabel4Alpha)
        medicationLabelTime4.alpha = CGFloat(medicationLabel4Alpha)
        medicationLabelDate4.alpha = CGFloat(medicationLabel4Alpha)
        
        // Sets text for the fifth medication
        medicationLabel4.text = medicationName4
        medicationLabelTime4.text = medicationTime4
        medicationLabelDate4.text = medicationDate4
        
        // Sets text for the username and password
        emailTextField.text = username
        passwordTextField.text = password
    }
    
    
    /**
     Function that validates text fields
     
     - Returns: String
     **/
    func validateFields() -> String? {
        // Remove extra spaces from username and password
        username = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPassword = confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check that all fields are filled in
        if username.count == 0  || password.count == 0 || confirmPassword!.count == 0 {
            return "Please fill in all fields"
        }
        
        // Check that the password matches the confirm password textfield
        if password != confirmPassword {
            
            // Clear confirm password textfield
            confirmPasswordTextField.text = ""
            
            return "Passwords do not match. Re-enter your password."
        }
        
        return nil
    }
    
    
    /**
     Function to create a new account. Will validate,  log in and move to home page if signup was successful
     
     - Returns: None
     **/
    @objc func createAnAccountTapped() {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil{
            // If there is something wrong with the fields, show error message
            showError(error!)
        }
        else{
            // Obtain username and password from text fields
            username = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: username, password: password) { (result, err) in
                if err != nil {
                    // Retrieve error description
                    let errorDesc = AuthErrorCode(rawValue: err!._code)
                    
                    // Check that the password is at least 6 characters long
                    if password.count < 6 {
                        self.showError("Password must be at least 6 characters")
                    }
                    else {
                        switch errorDesc {
                        // Invalid email format
                        case .invalidEmail:
                            self.errorLabel.text = "Invalid email format. Enter a valid email."
                        // User alreasy exists with that email address
                        case .emailAlreadyInUse:
                            self.errorLabel.text = "User already exists. Enter a different email address."
                        default:
                            self.errorLabel.text = "Unknown error"
                        }
                    }
                    
                    // Display error on screen
                    self.errorLabel.alpha = 1
                }
                else
                {
                    //User was created successfully, now store the username
                    let db = Firestore.firestore()
                    
                    // Store current info into database
                    db.collection("users").document(result!.user.uid).setData([
                        "Username": username,
                        "uid": result!.user.uid,
                        "MedicationName": medicationName,
                        "MedicationDate": medicationDate,
                        "MedicationTime": medicationTime,
                        "MedicationName1": medicationName1,
                        "MedicationDate1": medicationDate1,
                        "MedicationTime1": medicationTime1,
                        "MedicationName2": medicationName2,
                        "MedicationDate2": medicationDate2,
                        "MedicationTime2": medicationTime2,
                        "MedicationName3": medicationName3,
                        "MedicationDate3": medicationDate3,
                        "MedicationTime3": medicationTime3,
                        "MedicationName4": medicationName4,
                        "MedicationDate4": medicationDate4,
                        "MedicationTime4": medicationTime4,
                        "login_time": rightNow - 3600*24,
                        "Game_One_lastMaxScore": 0,
                        "Game_Two_lastMaxScore": 0,
                        "feeling": feeling
                    ]) { (error) in
                        if error != nil {
                            //Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    //Transition to the home screen
                    let homeViewController:HomeViewController = HomeViewController()
                    homeViewController.modalPresentationStyle = .fullScreen
                    self.present(homeViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    /**
     Function to Add New Medication, will direct you to Medication Detail Page, and save the username and password into constant which later on when you go back to the page, the username and password will still remain in the sign up page
     
     - Returns: None
     **/
    @objc func addNewMedicationDetailTapped() {
        // Save username and password typed into text fields
        username = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Transitions to the medication view controller
        let medicationViewController:MedicationDetailViewController = MedicationDetailViewController()
        medicationViewController.modalPresentationStyle = .fullScreen
        self.present(medicationViewController, animated: true, completion: nil)
    }
    
    
    /**
     Function that will lead you back to login page if button is pressed
     
     - Returns: None
     **/
    @objc func alreadyHaveAnAccountTapped() {
        // Transitions to the login view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /**
     Function that displays any error messages
     
     - Parameter message: String containing error message
     - Returns: None
     **/
    func showError(_ message:String){
        // Set error messages and show error
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
