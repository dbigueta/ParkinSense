//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        textfield.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        //textfield.layer.addSublayer(bottomLine)
        
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
