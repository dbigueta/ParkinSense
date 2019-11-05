//-----------------------------------------------------------------
//  File: SignupViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng
//
//  Description: Main view of the signup page - allows registration of new users
//
//  Changes:
//      - list change here
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import UIKit
import FirebaseAuth
import Firebase

class SignupViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var medicationLabel: UILabel!
    
    @IBOutlet weak var createAnAccountButton: UIButton!
    
    @IBOutlet weak var addNewMedicationDetailButton: UIButton!
    
    @IBOutlet weak var alreadyHaveAnAccountButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElement()
    }
    
    
    /**
        Function to set up the default ErrorLabel invisible and set up the button and text appearance
     
         - Returns: No
    **/
    func setUpElement(){
        
        //Hide the error label, medication label and save the Username and Password
        errorLabel.alpha = 0
        
        medicationLabel.alpha = CGFloat(medicationLabelAlpha)
        medicationLabel.text = medicationName
        
        usernameTextField.text = username
        passwordTextField.text = password
        
        //Style the elements
        Utilities.styleTextField(usernameTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(confirmPasswordTextField)
        Utilities.styleHollowButton(createAnAccountButton)
        Utilities.styleFilledButton(addNewMedicationDetailButton)
        
    }
    
    
    /**
        Function to get the error message from text field for username and password
     
         - Returns: String
    **/
    func validateFields() -> String? {
        //Check that all fields are filled in
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
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
            username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
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
                    
                    db.collection("users").document(result!.user.uid).setData(["Username": username, "uid": result!.user.uid, "MedicationName": medicationName, "login_time":rightNow - 3600*24]) { (error) in
                        
                        if error != nil {
                            //Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    //Transition to the home screen
                    self.performSegue(withIdentifier: "signUpToHomeID", sender: nil)
                }
            }
        }
    }
    
    
    /**
        Function to Add New Medication, will direct you to Medication Detail Page, and save the username and password into constant which later on when you go back to the page, the username and password will still remain in the sign up page
     
         - Parameter sender: Button itself
         - Returns: None
    **/
    @IBAction func addNewMedicationDetailTapped(_ sender: Any) {
        username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    /**
        Function that will lead you back to login page if button is pressed
     
         - Parameter sender: Self Button
         - Returns: None
    **/
    @IBAction func alreadyHaveAnAccountTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindTologin", sender: nil)
    }
    
    
    /**
        Function about the Back to the current page Button,
     
         - Parameter sender: Button itself
         - Returns: None
    **/
    @IBAction func unwindToSignup(segue: UIStoryboardSegue){
        
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
