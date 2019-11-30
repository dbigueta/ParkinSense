//-----------------------------------------------------------------
//  File: MedicationDetailViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng, Hamlet Jiang Su
//
//  Description: Main view of the medication page - allows registration of new medication
//
//  Changes:
//      - Refactored code to programmatically code UI elements
//      - Check the time picker time zone
//      - Add the Medicaiton name to Firebase
//
//  Known Bugs:
//      - Need to put the time picker time to Signup page
//
//-----------------------------------------------------------------

import UIKit
import BEMCheckBox

class MedicationDetailViewController: UIViewController, UITextFieldDelegate {
    
    // App Logo UI Image
    let appImageView: UIImageView = {
        let imageView = UIImageView(image: appImage!)
        Utilities.styleImageView(imageView)
        return imageView
    }()
    
    // Medication Label UI Label Header
    let medicationTitleLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "ADD MEDICATION DETAIL"
        label.font = UIFont.systemFont(ofSize: headerLabelHeight, weight: .medium)
        return label
    }()
    
    // Medication Label UI Label
    let medicationLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "Medication"
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .regular)
        return label
    }()
    
    // Medication UI Textfield to input medication
    let medicationTextField: CustomTextField = {
        let textField = CustomTextField()
        Utilities.styleTextField(textField, password: false)
        textField.attributedPlaceholder = NSAttributedString(string: "Medication", attributes: [NSAttributedString.Key.foregroundColor: textColour])
        textField.paddingValue = paddingVal
        textField.awakeFromNib()
        textField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light)
        textField.keyboardType = UIKeyboardType.emailAddress
        return textField
    }()
    
    // Medication Day Label UI Label
    let medicationDayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "Medication Dates"
        label.font = UIFont.systemFont(ofSize: medicationDayLabelHeight, weight: .regular)
        return label
    }()
    
    // Sunday UI Label
    let sundayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "S"
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light)
        return label
    }()
    
    // Monday UI Label
    let mondayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "M"
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light)
        return label
    }()
    
    // Tuesday UI Label
    let tuesdayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "T"
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light)
        return label
    }()
    
    // Wednesday UI Label
    let wednesdayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "W"
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light)
        return label
    }()
    
    // Thursday UI Label
    let thursdayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "T"
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light)
        return label
    }()
    
    // Friday UI Label
    let fridayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "F"
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light)
        return label
    }()
    
    // Saturday UI Label
    let saturdayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "S"
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light)
        return label
    }()
    
    // Sunday Checkbox
    let sundayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button)
        return button
    }()
    
    // Monday Checkbox
    let mondayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button)
        return button
    }()
    
    // Tuesday Checkbox
    let tuesdayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button)
        return button
    }()
    
    // Wednesday Checkbox
    let wednesdayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button)
        return button
    }()
    
    // Thursday Checkbox
    let thursdayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button)
        return button
    }()
    
    // Friday Checkbox
    let fridayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button)
        return button
    }()
    
    // Saturday Checkbox
    let saturdayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button)
        return button
    }()
    
    // Medication Time Label UI Label
    let medicationTimeLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false)
        label.text = "Medication Times"
        label.font = UIFont.systemFont(ofSize: medicationTimeLabelHeight, weight: .regular)
        return label
    }()
    
    // Medication Time Picker
    let timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        Utilities.styleTimePicker(timePicker)
        return timePicker
    }()
    
    // Cancel Button
    let cancelButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button)
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(cancelButtonFunc), for: .touchUpInside)
        return button
    }()
    
    // Add new medication Button
    let addNewMedicationButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button)
        button.setTitle("Add New Medication", for: .normal)
        button.addTarget(self, action: #selector(addNewMedicationButton(_:)), for: .touchUpInside)
        return button
    }()

    override func loadView() {
        super.loadView()
        
        self.view.addSubview(appImageView)
        self.view.addSubview(medicationTitleLabel)
        self.view.addSubview(medicationLabel)
        self.view.addSubview(medicationTextField)
        self.view.addSubview(medicationDayLabel)
        
        self.view.addSubview(sundayLabel)
        self.view.addSubview(mondayLabel)
        self.view.addSubview(tuesdayLabel)
        self.view.addSubview(wednesdayLabel)
        self.view.addSubview(thursdayLabel)
        self.view.addSubview(fridayLabel)
        self.view.addSubview(saturdayLabel)
        
        self.view.addSubview(sundayButton)
        self.view.addSubview(mondayButton)
        self.view.addSubview(tuesdayButton)
        self.view.addSubview(wednesdayButton)
        self.view.addSubview(thursdayButton)
        self.view.addSubview(fridayButton)
        self.view.addSubview(saturdayButton)
        
        self.view.addSubview(medicationTimeLabel)
        self.view.addSubview(timePicker)
        
        self.view.addSubview(cancelButton)
        self.view.addSubview(addNewMedicationButton)
        
        appImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        appImageView.heightAnchor.constraint(equalToConstant: appImageHeaderHeight).isActive = true
        appImageView.widthAnchor.constraint(equalToConstant: appImageHeaderHeight).isActive = true
        appImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        
        medicationTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0).isActive = true
        medicationTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: appImageHeight + 32.0).isActive = true
        
        medicationLabel.topAnchor.constraint(equalTo: medicationTitleLabel.topAnchor, constant: headerLabelHeight + 32.0).isActive = true
        medicationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        medicationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        medicationTextField.topAnchor.constraint(equalTo: medicationLabel.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        medicationTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        medicationDayLabel.topAnchor.constraint(equalTo: medicationTextField.topAnchor, constant: textFieldHeight + 32.0).isActive = true
        medicationDayLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        medicationDayLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        sundayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        sundayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        sundayLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        mondayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        mondayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        mondayLabel.leadingAnchor.constraint(equalTo: sundayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        tuesdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        tuesdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        tuesdayLabel.leadingAnchor.constraint(equalTo: mondayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        wednesdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        wednesdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        wednesdayLabel.leadingAnchor.constraint(equalTo: tuesdayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        thursdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        thursdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        thursdayLabel.leadingAnchor.constraint(equalTo: wednesdayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        fridayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        fridayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        fridayLabel.leadingAnchor.constraint(equalTo: thursdayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        saturdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        saturdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        saturdayLabel.leadingAnchor.constraint(equalTo: fridayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        sundayButton.topAnchor.constraint(equalTo: sundayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        sundayButton.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        sundayButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: offset).isActive = true
        
        mondayButton.topAnchor.constraint(equalTo: mondayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        mondayButton.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        mondayButton.leadingAnchor.constraint(equalTo: sundayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        tuesdayButton.topAnchor.constraint(equalTo: tuesdayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        tuesdayButton.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        tuesdayButton.leadingAnchor.constraint(equalTo: mondayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        wednesdayButton.topAnchor.constraint(equalTo: wednesdayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        wednesdayButton.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        wednesdayButton.leadingAnchor.constraint(equalTo: tuesdayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        thursdayButton.topAnchor.constraint(equalTo: thursdayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        thursdayButton.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        thursdayButton.leadingAnchor.constraint(equalTo: wednesdayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        fridayButton.topAnchor.constraint(equalTo: fridayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        fridayButton.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        fridayButton.leadingAnchor.constraint(equalTo: thursdayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        saturdayButton.topAnchor.constraint(equalTo: saturdayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        saturdayButton.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        saturdayButton.leadingAnchor.constraint(equalTo: fridayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        medicationTimeLabel.topAnchor.constraint(equalTo: sundayLabel.topAnchor, constant: dayLabelHeight + CGFloat(checkboxDiameter) + 32.0).isActive = true
        medicationTimeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        medicationTimeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        timePicker.topAnchor.constraint(equalTo: medicationTimeLabel.topAnchor, constant: medicationTimeLabelHeight + 16.0).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: timePickerHeight).isActive = true
        timePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        timePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        cancelButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        addNewMedicationButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 0 - UIButtonHeight - 16.0).isActive = true
        addNewMedicationButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        addNewMedicationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        addNewMedicationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
    }
     override func viewDidLoad() {
            super.viewDidLoad()

            //Sets background of view controller
            self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
            
            medicationTextField.delegate = self
            
            //Looks for single or multiple taps.
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
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
            Function about the add new medication Button, will direct you back to the sign up page and medication will be displayed on the screen
         
             - Parameter sender: Button itself
         
             - Returns: No
                
        **/
        @objc func addNewMedicationButton(_ sender: Any) {
            
            if medicationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != ""
            {
                if medicationcount == 0{
                    medicationName = medicationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) //read the Medication Name from text field
                    medicationLabelAlpha = 1 //change the medicationLabel's alpha from 0 to 1 that display the medication information in sign up page
                }
                if medicationcount == 1 {
                    medicationName1 = medicationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) //read the Medication Name from text field
                    medicationLabel1Alpha = 1 //change the medicationLabel's alpha from 0 to 1 that display the medication information in sign up page
                }
                if medicationcount == 2 {
                    medicationName2 = medicationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) //read the Medication Name from text field
                    medicationLabel2Alpha = 1 //change the medicationLabel's alpha from 0 to 1 that display the medication information in sign up page
                }
                if medicationcount == 3 {
                    medicationName3 = medicationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) //read the Medication Name from text field
                    medicationLabel3Alpha = 1 //change the medicationLabel's alpha from 0 to 1 that display the medication information in sign up page
                }
                if medicationcount > 3 {
                    medicationName4 = medicationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) //read the Medication Name from text field
                    medicationLabel4Alpha = 1 //change the medicationLabel's alpha from 0 to 1 that display the medication information in sign up page
                }
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.short
                
                //timePickerTime = dateFormatter.string(from: timePicker.date) //read the timepicker value for later use
                
                print(timePickerTime)
            

                medicationcount+=1
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DoUpdateLabel"), object: nil, userInfo: nil)
            
            self.dismiss(animated: true, completion: nil)
        }
        
        /**
         Function that will lead you back to login page if button is pressed
         
         - Parameter sender: Self Button
         - Returns: None
         **/
        @objc func cancelButtonFunc(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
    }
