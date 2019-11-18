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
            return UIEdgeInsets(top: paddingValue/2, left: paddingValue, bottom: paddingValue/2, right: paddingValue)
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
    
    var bottomBorder = UIView()
    
    override func awakeFromNib() {
        
        // Setup Bottom-Border
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor(red:0.89, green:0.86, blue:0.82, alpha:1.0) // Set Border-Color
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomBorder)
        
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
        
    }
    
    @IBInspectable var paddingValue: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}
