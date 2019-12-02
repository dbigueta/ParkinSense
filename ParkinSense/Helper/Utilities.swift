//-----------------------------------------------------------------
//  File: Utilities.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng
//
//  Description: Setup the style/appearance of the button of Text 
//
//  Changes:
//      - None
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import Foundation
import UIKit
import BEMCheckBox

class Utilities: CustomTextField {
    
    static func styleTextField(_ textField: UITextField, password: Bool) {
        textField.textColor = textColour
        textField.tintColor = textColour
        textField.backgroundColor = .clear
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.translatesAutoresizingMaskIntoConstraints = false
        if password { textField.isSecureTextEntry = true }
    }
    
    static func styleUILabel(_ label: UILabel, error: Bool) {
        if error { label.textColor = UIColor(red:0.97, green:0.22, blue:0.35, alpha:1.0) }
        else { label.textColor = textColour }
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func styleUIButton(_ button: UIButton) {
        button.setTitleColor(buttonTextColour, for: .normal)
        button.backgroundColor = buttonColour
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func styleImageView(_ imageView: UIImageView) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
    }
    
    static func styleBEMCheckBox(_ checkbox: BEMCheckBox) {
        checkbox.onTintColor = UIColor(red:0.27, green:0.45, blue:0.62, alpha:1.0)
        checkbox.onCheckColor = UIColor(red:0.92, green:0.91, blue:0.88, alpha:1.0)
        checkbox.onFillColor = UIColor(red:0.27, green:0.45, blue:0.62, alpha:1.0)
        checkbox.tintColor = UIColor(red:0.27, green:0.45, blue:0.62, alpha:1.0)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func styleTimePicker(_ timePicker: UIDatePicker) {
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.backgroundColor = .clear
        timePicker.timeZone = NSTimeZone.local
        timePicker.datePickerMode = .time
    }
    
    /**
     Button style
     
     - Parameter sender: Button itself
     
     - Returns: None
     
     **/
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 42/255, green: 96/255, blue: 149/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    /**
     Button style
     
     - Parameter sender: Button itself
     
     - Returns: None
     
     **/
    static func styleFilledDateButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.gray
    }
    
    /**
     Button style
     
     - Parameter sender: Button itself
     
     - Returns: None
     
     **/
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    /**
     Check the pass word is Valid, the function will be used later
     
     - Parameter password: String
     
     - Returns: passwordTest.evaluate(with:password)
     
     **/
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
