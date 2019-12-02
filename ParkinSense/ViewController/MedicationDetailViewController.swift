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
    // MARK: Class Variables
    
    // App Logo UI Image
    let appImageView: UIImageView = {
        let imageView = UIImageView(image: appImage!)
        Utilities.styleImageView(imageView) // Styles image
        return imageView
    }()
    
    // Medication Label UI Label Header
    let medicationTitleLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "ADD MEDICATION DETAILS" // Set label text
        label.font = UIFont.systemFont(ofSize: headerLabelHeight, weight: .medium) // Set font size
        return label
    }()
    
    // Medication Label UI Label
    let medicationLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication" // Set label text
        label.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .regular) // Set font size
        return label
    }()
    
    // Medication UI Textfield to input medication
    let medicationTextField: CustomTextField = {
        let textField = CustomTextField()
        Utilities.styleTextField(textField, password: false) // Style textfield
        textField.attributedPlaceholder = NSAttributedString(string: "Medication", attributes: [NSAttributedString.Key.foregroundColor: textColour]) // Set text field placeholder text
        textField.paddingValue = paddingVal // Set text field padding
        textField.awakeFromNib()
        textField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light) // Set font size
        textField.keyboardType = UIKeyboardType.emailAddress
        return textField
    }()
    
    // Medication Day Label UI Label
    let medicationDayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Dates" // Set label text
        label.font = UIFont.systemFont(ofSize: medicationDayLabelHeight, weight: .regular) // Set font size
        return label
    }()
    
    // Sunday UI Label
    let sundayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "S" // Set label text
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light) // Set font size
        return label
    }()
    
    // Monday UI Label
    let mondayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "M" // Set label text
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light) // Set font size
        return label
    }()
    
    // Tuesday UI Label
    let tuesdayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "T" // Set label text
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light) // Set font size
        return label
    }()
    
    // Wednesday UI Label
    let wednesdayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "W" // Set label text
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light) // Set font size
        return label
    }()
    
    // Thursday UI Label
    let thursdayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "T" // Set label text
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light) // Set font size
        return label
    }()
    
    // Friday UI Label
    let fridayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "F" // Set label text
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light) // Set font size
        return label
    }()
    
    // Saturday UI Label
    let saturdayLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "S" // Set label text
        label.font = UIFont.systemFont(ofSize: dayLabelHeight, weight: .light) // Set font size
        return label
    }()
    
    // Sunday Checkbox
    let sundayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button) // Styles checkbox
        return button
    }()
    
    // Monday Checkbox
    let mondayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button) // Styles checkbox
        return button
    }()
    
    // Tuesday Checkbox
    let tuesdayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button) // Styles checkbox
        return button
    }()
    
    // Wednesday Checkbox
    let wednesdayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button) // Styles checkbox
        return button
    }()
    
    // Thursday Checkbox
    let thursdayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button) // Styles checkbox
        return button
    }()
    
    // Friday Checkbox
    let fridayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button) // Styles checkbox
        return button
    }()
    
    // Saturday Checkbox
    let saturdayButton: BEMCheckBox = {
        let button = BEMCheckBox()
        Utilities.styleBEMCheckBox(button) // Styles checkbox
        return button
    }()
    
    // Medication Time Label UI Label
    let medicationTimeLabel: UILabel = {
        let label = UILabel()
        Utilities.styleUILabel(label, error: false) // Styles label
        label.text = "Medication Times" // Set label text
        label.font = UIFont.systemFont(ofSize: medicationTimeLabelHeight, weight: .regular) // Set font size
        return label
    }()
    
    // Medication Time Picker
    let timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        Utilities.styleTimePicker(timePicker) // Styles time picker
        return timePicker
    }()
    
    // Cancel Button
    let cancelButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button) // Styles button
        button.setTitle("Cancel", for: .normal) // Set button label
        button.addTarget(self, action: #selector(cancelButtonFunc), for: .touchUpInside) // Set function to trigger when tapped
        return button
    }()
    
    // Add new medication Button
    let addNewMedicationButton: UIButton = {
        let button = UIButton()
        Utilities.styleUIButton(button) // Styles button
        button.setTitle("Add New Medication", for: .normal) // Set button label
        button.addTarget(self, action: #selector(addNewMedicationButtonPressed), for: .touchUpInside) // Set function to trigger when tapped
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
        self.view.addSubview(medicationTitleLabel)
        self.view.addSubview(medicationLabel)
        self.view.addSubview(medicationTextField)
        self.view.addSubview(medicationDayLabel)
        
        // Adds each view, label into the current screen
        self.view.addSubview(sundayLabel)
        self.view.addSubview(mondayLabel)
        self.view.addSubview(tuesdayLabel)
        self.view.addSubview(wednesdayLabel)
        self.view.addSubview(thursdayLabel)
        self.view.addSubview(fridayLabel)
        self.view.addSubview(saturdayLabel)
        
        // Adds all checkboxes to current screen
        self.view.addSubview(sundayButton)
        self.view.addSubview(mondayButton)
        self.view.addSubview(tuesdayButton)
        self.view.addSubview(wednesdayButton)
        self.view.addSubview(thursdayButton)
        self.view.addSubview(fridayButton)
        self.view.addSubview(saturdayButton)
        
        // Adds timepicker related labels to current screen
        self.view.addSubview(medicationTimeLabel)
        self.view.addSubview(timePicker)
        
        // Adds all buttons to current screen
        self.view.addSubview(cancelButton)
        self.view.addSubview(addNewMedicationButton)
        
        // Set App Image constraints to allow for multiple device configurations
        appImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        appImageView.heightAnchor.constraint(equalToConstant: appImageHeaderHeight).isActive = true
        appImageView.widthAnchor.constraint(equalToConstant: appImageHeaderHeight).isActive = true
        appImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        
        // Set Medication title constraints to allow for multiple device configurations
        medicationTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0).isActive = true
        medicationTitleLabel.leadingAnchor.constraint(equalTo: appImageView.leadingAnchor, constant: appImageHeaderHeight + 32.0).isActive = true
        
        // Set medication header constraints to allow for multiple device configurations
        medicationLabel.topAnchor.constraint(equalTo: medicationTitleLabel.topAnchor, constant: headerLabelHeight + 32.0).isActive = true
        medicationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        medicationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        // Set medication text field constraints to allow for multiple device configurations
        medicationTextField.topAnchor.constraint(equalTo: medicationLabel.topAnchor, constant: medicationLabelHeight + 16.0).isActive = true
        medicationTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        medicationTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        // Set medication day header constraints to allow for multiple device configurations
        medicationDayLabel.topAnchor.constraint(equalTo: medicationTextField.topAnchor, constant: textFieldHeight + 32.0).isActive = true
        medicationDayLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        medicationDayLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        // Set day constraints to allow for multiple device configurations
        sundayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        sundayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        sundayLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        // Set day constraints to allow for multiple device configurations
        mondayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        mondayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        mondayLabel.leadingAnchor.constraint(equalTo: sundayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set day constraints to allow for multiple device configurations
        tuesdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        tuesdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        tuesdayLabel.leadingAnchor.constraint(equalTo: mondayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set day constraints to allow for multiple device configurations
        wednesdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        wednesdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        wednesdayLabel.leadingAnchor.constraint(equalTo: tuesdayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set day constraints to allow for multiple device configurations
        thursdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        thursdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        thursdayLabel.leadingAnchor.constraint(equalTo: wednesdayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set day constraints to allow for multiple device configurations
        fridayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        fridayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        fridayLabel.leadingAnchor.constraint(equalTo: thursdayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set day constraints to allow for multiple device configurations
        saturdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0).isActive = true
        saturdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        saturdayLabel.leadingAnchor.constraint(equalTo: fridayLabel.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set day checkbox constraints to allow for multiple device configurations
        sundayButton.topAnchor.constraint(equalTo: sundayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        sundayButton.widthAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        sundayButton.heightAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        sundayButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: offset).isActive = true
        
        // Set day checkbox constraints to allow for multiple device configurations
        mondayButton.topAnchor.constraint(equalTo: mondayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        mondayButton.widthAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        mondayButton.heightAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        mondayButton.leadingAnchor.constraint(equalTo: sundayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set day checkbox constraints to allow for multiple device configurations
        tuesdayButton.topAnchor.constraint(equalTo: tuesdayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        tuesdayButton.widthAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        tuesdayButton.heightAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        tuesdayButton.leadingAnchor.constraint(equalTo: mondayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set day checkbox constraints to allow for multiple device configurations
        wednesdayButton.topAnchor.constraint(equalTo: wednesdayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        wednesdayButton.widthAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        wednesdayButton.heightAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        wednesdayButton.leadingAnchor.constraint(equalTo: tuesdayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set day checkbox constraints to allow for multiple device configurations
        thursdayButton.topAnchor.constraint(equalTo: thursdayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        thursdayButton.widthAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        thursdayButton.heightAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        thursdayButton.leadingAnchor.constraint(equalTo: wednesdayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set day checkbox constraints to allow for multiple device configurations
        fridayButton.topAnchor.constraint(equalTo: fridayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        fridayButton.widthAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        fridayButton.heightAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        fridayButton.leadingAnchor.constraint(equalTo: thursdayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set day checkbox constraints to allow for multiple device configurations
        saturdayButton.topAnchor.constraint(equalTo: saturdayLabel.topAnchor, constant: dayLabelHeight + 16.0).isActive = true
        saturdayButton.widthAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        saturdayButton.heightAnchor.constraint(equalToConstant: checkboxHeightDays).isActive = true
        saturdayButton.leadingAnchor.constraint(equalTo: fridayButton.leadingAnchor, constant: sectionWidth).isActive = true
        
        // Set medication time header constraints to allow for multiple device configurations
        medicationTimeLabel.topAnchor.constraint(equalTo: sundayLabel.topAnchor, constant: dayLabelHeight + CGFloat(checkboxDiameter) + 32.0).isActive = true
        medicationTimeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        medicationTimeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        // Set time picker constraints to allow for multiple device configurations
        timePicker.topAnchor.constraint(equalTo: medicationTimeLabel.topAnchor, constant: medicationTimeLabelHeight + 16.0).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: timePickerHeight).isActive = true
        timePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        timePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        // Set cancel button constraints to allow for multiple device configurations
        cancelButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
        
        // Set add medication button constraints to allow for multiple device configurations
        addNewMedicationButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 0 - UIButtonHeight - 16.0).isActive = true
        addNewMedicationButton.heightAnchor.constraint(equalToConstant: UIButtonHeight).isActive = true
        addNewMedicationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0).isActive = true
        addNewMedicationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0).isActive = true
    }
    
    
    /**
     Function that sets up controls for on screen keyboard dismissal
     
     - Returns: None
     **/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets background of view controller
        self.view.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
        
        // Adds delegates to allow the removal of the onscreen keyboard
        medicationTextField.delegate = self
        
        // Looks for single or multiple taps for removal of onscreen keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
     Function to add new medication details and set its display on the sign up view controller
     
     - Returns: None
     **/
    @objc func addNewMedicationButtonPressed() {
        
        // Holds the days selected in the medication time section
        var daysSelected = ""
        
        // Add the corresponding dates of each checkbox if it was checked
        if sundayButton.on {daysSelected = daysSelected + "Su "}
        if mondayButton.on {daysSelected = daysSelected + "Mo "}
        if tuesdayButton.on {daysSelected = daysSelected + "Tu "}
        if wednesdayButton.on {daysSelected = daysSelected + "We "}
        if thursdayButton.on {daysSelected = daysSelected + "Th "}
        if fridayButton.on {daysSelected = daysSelected + "Fr "}
        if saturdayButton.on {daysSelected = daysSelected + "Sa "}
        
        // Retrieves medication name details
        let medicationText = medicationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if medicationText.count != 0 && daysSelected != ""
        {
            // Sets up date formatting that will grab values from timePicker
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.short
            
            // Sets medication name, dates, time and displays it on the sign up view controller
            if medicationcount == 0 {
                medicationName = medicationText
                medicationTime = dateFormatter.string(from: timePicker.date)
                medicationDate = daysSelected
                medicationLabelAlpha = 1
            }
            // Sets medication name, dates, time if there are 2 medications
            if medicationcount == 1 {
                medicationName1 = medicationText
                medicationTime1 = dateFormatter.string(from: timePicker.date)
                medicationDate1 = daysSelected
                medicationLabel1Alpha = 1
            }
            // Sets medication name, dates, time if there are 3 medications
            if medicationcount == 2 {
                medicationName2 = medicationText
                medicationTime2 = dateFormatter.string(from: timePicker.date)
                medicationDate2 = daysSelected
                medicationLabel2Alpha = 1
            }
            // Sets medication name, dates, time if there are 4 medications
            if medicationcount == 3 {
                medicationName3 = medicationText
                medicationTime3 = dateFormatter.string(from: timePicker.date)
                medicationDate3 = daysSelected
                medicationLabel3Alpha = 1
            }
            // Sets medication name, dates, time if there are 5 or more medications
            if medicationcount > 3 {
                medicationName4 = medicationText
                medicationTime4 = dateFormatter.string(from: timePicker.date)
                medicationDate4 = daysSelected
                medicationLabel4Alpha = 1
            }
            
            // Add medication count to keep track of total medication inputted
            medicationcount += 1
            
            // Notifies sign up view controller to update its labels
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DoUpdateLabel"), object: nil, userInfo: nil)
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /**
     Function that will lead you back to login page if button is pressed
     
     - Returns: None
     **/
    @objc func cancelButtonFunc() {
        self.dismiss(animated: true, completion: nil)
    }
}
