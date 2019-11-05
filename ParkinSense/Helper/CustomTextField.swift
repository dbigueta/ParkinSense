//-----------------------------------------------------------------
//  File: CustomTextField.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Hamlet Jiang Su
//
//  Description: Custom class to add some padding between the actual text and the text field in the storyboard
//
//  Changes:
//      - Added UIEdgeInsets to create padding within text fields
//
//  Known Bugs:
//      - None
//
//-----------------------------------------------------------------

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    /**
        Adds padding the the right of the text field
     
         - Returns: UIEdgeInsets
            
    **/
    var padding: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: 0, left: paddingValue, bottom: 0, right: paddingValue)
        }
    }
    
    
    /**
        Adds padding the the right of the text within a text field
     
         - Returns: CGRect with new bounds determined by the padding
            
    **/
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
    /**
        Adds padding the the right of any placeholder text within a text field
     
         - Returns: CGRect with new bounds determined by the padding
            
    **/
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
    /**
        Adds padding the the right of the text within a text field when editing
     
         - Returns: CGRect with new bounds determined by the padding
            
    **/
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    @IBInspectable var paddingValue: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}
