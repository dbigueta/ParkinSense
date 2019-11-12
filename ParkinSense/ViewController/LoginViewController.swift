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

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var rememberPasswordLabel: UILabel!
    
    @IBOutlet weak var btnCheckBox: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var oRlabel: UILabel!
    
    @IBOutlet weak var createAnAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
        btnCheckBox.setImage(UIImage(named:"uncheckbox"), for: .normal)
        btnCheckBox.setImage(UIImage(named:"checkbox"), for: .selected)
    }
    
    
    /**
        Function to set up the default ErrorLabel invisiable and set up the button and text appearance
     
         - Returns: None
    **/
    func setUpElements(){
        
        //Hide the error label
        errorLabel.alpha = 0
        
        //Style the elements 
        Utilities.styleTextField(usernameTextField)
        
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(signInButton)
        
        Utilities.styleFilledButton(createAnAccountButton)
    }
    

    /**
        Function about the Remember Password Button check or uncheck
     
         - Parameter sender: Button itself
         - Returns: None
    **/
    @IBAction func checkMarkTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        
    }
    
    
    /**
        Function about the Sign in Button, will direct you to the home page if success. If not, the error will be displayed
     
         - Parameter sender: Button itself
         - Returns: None
    **/
    @IBAction func signInTapped(_ sender: Any) {
        
        //validate Text Fields
        
        //Create cleaned versions of the text field
        username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            
            if error != nil {
                //could not sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{

                self.performSegue(withIdentifier: "loginToHomeID", sender: nil)
                
            }
        }
        
    }
    
    
    /**
        Function that directs you to Create an Account
     
         - Parameter sender: Button itself
         - Returns: None
    **/
    @IBAction func createAccountTapped(_ sender: Any) {
    }
    
    
    /**
        Function to go back to Login
     
         - Parameter sender: Button itself
         - Returns: None
            
    **/
    @IBAction func unwindToLogin(segue: UIStoryboardSegue){
        
    }
    
}
