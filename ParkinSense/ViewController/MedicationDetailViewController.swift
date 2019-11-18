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
    
    let medicationTextField =  CustomTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
    
    let screenSize = UIScreen.main.bounds
    
    let timePicker = UIDatePicker()

    let medicationTitleLabel = UILabel()
    let medicationLabel = UILabel()
    let medicationDayLabel = UILabel()
    let medicationTimeLabel = UILabel()
    
    let sundayLabel = UILabel()
    let mondayLabel = UILabel()
    let tuesdayLabel = UILabel()
    let wednesdayLabel = UILabel()
    let thursdayLabel = UILabel()
    let fridayLabel = UILabel()
    let saturdayLabel = UILabel()
    
    let addNewMedicationButton = UIButton()
    let cancelButton = UIButton()
    
    let textColour = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
    let buttonColour = UIColor(red:0.75, green:0.85, blue:0.84, alpha:1.0)
    let font = UIFont.systemFont(ofSize: 20, weight: .light)
    let checkboxDiameter = 35
    
    let cancelButtonHeight: CGFloat = 45
    let addNewMedicationButtonHeight: CGFloat = 45
    
    override func loadView() {
        super.loadView()
        
        let sectionWidth = screenSize.width/7
        let offset = (sectionWidth - CGFloat(checkboxDiameter))/2
        
        // App Logo UI Image
        let appImageName = "AppLogoImage.png"
        let appImageHeight:CGFloat = 50
        let appImage = UIImage(named: appImageName)
        let appImageView = UIImageView(image: appImage!)
        appImageView.frame = CGRect(x: 0, y: 0, width: appImageHeight, height: appImageHeight)
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        appImageView.contentMode = .scaleAspectFit
        self.view.addSubview(appImageView)
        
        NSLayoutConstraint.activate([
            appImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            appImageView.heightAnchor.constraint(equalToConstant: appImageHeight),
            appImageView.widthAnchor.constraint(equalToConstant: appImageHeight),
            appImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
        ])
        
        // Add Medication Detail UI Label
        let medicationTitleLabelHeight: CGFloat = 17
        medicationTitleLabel.textColor = textColour
        medicationTitleLabel.textAlignment = .center
        medicationTitleLabel.text = "ADD MEDICATION DETAIL"
        medicationTitleLabel.numberOfLines = 1
        medicationTitleLabel.font = UIFont.systemFont(ofSize: medicationTitleLabelHeight, weight: .medium)
        medicationTitleLabel.adjustsFontSizeToFitWidth = true
        medicationTitleLabel.minimumScaleFactor = 0.5
        medicationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(medicationTitleLabel)

        NSLayoutConstraint.activate([
            medicationTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            medicationTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: appImageHeight + 32.0),
        ])
        
        // Medication UI Label
        let medicationLabelHeight: CGFloat = 20
        medicationLabel.textColor = textColour
        medicationLabel.textAlignment = .left
        medicationLabel.text = "Medication Name/ID"
        medicationLabel.numberOfLines = 1
        medicationLabel.font = UIFont.systemFont(ofSize: medicationLabelHeight, weight: .regular)
        medicationLabel.adjustsFontSizeToFitWidth = true
        medicationLabel.minimumScaleFactor = 0.5
        medicationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(medicationLabel)

        NSLayoutConstraint.activate([
            medicationLabel.topAnchor.constraint(equalTo: medicationTitleLabel.topAnchor, constant: medicationTitleLabelHeight + 32.0),
            medicationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            medicationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])

        // Medication Detail UI Textfield
        let paddingVal:CGFloat = 10
        let textFieldFontSize:CGFloat = 20
        let medicationTextFieldHeight: CGFloat = textFieldFontSize + paddingVal
        medicationTextField.textColor = textColour
        medicationTextField.attributedPlaceholder = NSAttributedString(string: "Medication", attributes: [NSAttributedString.Key.foregroundColor: textColour])
        medicationTextField.paddingValue = paddingVal
        medicationTextField.awakeFromNib()
        medicationTextField.font = UIFont.systemFont(ofSize: textFieldFontSize, weight: .light)
        medicationTextField.backgroundColor = .clear
        medicationTextField.autocorrectionType = UITextAutocorrectionType.no
        medicationTextField.keyboardType = UIKeyboardType.default
        medicationTextField.autocapitalizationType = UITextAutocapitalizationType.none
        medicationTextField.returnKeyType = UIReturnKeyType.done
        medicationTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        medicationTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        medicationTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(medicationTextField)

        NSLayoutConstraint.activate([
            medicationTextField.topAnchor.constraint(equalTo: medicationLabel.topAnchor, constant: medicationLabelHeight + 16.0),
            medicationTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            medicationTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
        ])
        
        // Medication Day UI Label
        let medicationDayLabelHeight: CGFloat = 20
        medicationDayLabel.textColor = textColour
        medicationDayLabel.textAlignment = .left
        medicationDayLabel.text = "Medication Dates"
        medicationDayLabel.numberOfLines = 1
        medicationDayLabel.font = UIFont.systemFont(ofSize: medicationDayLabelHeight, weight: .regular)
        medicationDayLabel.adjustsFontSizeToFitWidth = true
        medicationDayLabel.minimumScaleFactor = 0.5
        medicationDayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(medicationDayLabel)

        NSLayoutConstraint.activate([
            medicationDayLabel.topAnchor.constraint(equalTo: medicationTextField.topAnchor, constant: medicationTextFieldHeight + 32.0),
            medicationDayLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            medicationDayLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // Sunday UI Label
        let sundayLabelHeight: CGFloat = 17
        sundayLabel.textColor = textColour
        sundayLabel.textAlignment = .center
        sundayLabel.text = "S"
        sundayLabel.numberOfLines = 1
        sundayLabel.font = UIFont.systemFont(ofSize: sundayLabelHeight, weight: .light)
        sundayLabel.adjustsFontSizeToFitWidth = true
        sundayLabel.minimumScaleFactor = 0.5
        sundayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sundayLabel)

        NSLayoutConstraint.activate([
            sundayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0),
            sundayLabel.widthAnchor.constraint(equalToConstant: sectionWidth),
            sundayLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
        
        // Monday UI Label
        let mondayLabelHeight: CGFloat = 17
        mondayLabel.textColor = textColour
        mondayLabel.textAlignment = .center
        mondayLabel.text = "M"
        mondayLabel.numberOfLines = 1
        mondayLabel.font = UIFont.systemFont(ofSize: mondayLabelHeight, weight: .light)
        mondayLabel.adjustsFontSizeToFitWidth = true
        mondayLabel.minimumScaleFactor = 0.5
        mondayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mondayLabel)

        NSLayoutConstraint.activate([
            mondayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0),
            mondayLabel.widthAnchor.constraint(equalToConstant: sectionWidth),
            mondayLabel.leadingAnchor.constraint(equalTo: sundayLabel.leadingAnchor, constant: sectionWidth)
        ])
        
        // Tuesday UI Label
        let tuesdayLabelHeight: CGFloat = 17
        tuesdayLabel.textColor = textColour
        tuesdayLabel.textAlignment = .center
        tuesdayLabel.text = "T"
        tuesdayLabel.numberOfLines = 1
        tuesdayLabel.font = UIFont.systemFont(ofSize: tuesdayLabelHeight, weight: .light)
        tuesdayLabel.adjustsFontSizeToFitWidth = true
        tuesdayLabel.minimumScaleFactor = 0.5
        tuesdayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tuesdayLabel)

        NSLayoutConstraint.activate([
            tuesdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0),
            tuesdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth),
            tuesdayLabel.leadingAnchor.constraint(equalTo: mondayLabel.leadingAnchor, constant: sectionWidth)
        ])
        
        // Wednesday UI Label
        let wednesdayLabelHeight: CGFloat = 17
        wednesdayLabel.textColor = textColour
        wednesdayLabel.textAlignment = .center
        wednesdayLabel.text = "W"
        wednesdayLabel.numberOfLines = 1
        wednesdayLabel.font = UIFont.systemFont(ofSize: wednesdayLabelHeight, weight: .light)
        wednesdayLabel.adjustsFontSizeToFitWidth = true
        wednesdayLabel.minimumScaleFactor = 0.5
        wednesdayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(wednesdayLabel)

        NSLayoutConstraint.activate([
            wednesdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0),
            wednesdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth),
            wednesdayLabel.leadingAnchor.constraint(equalTo: tuesdayLabel.leadingAnchor, constant: sectionWidth)
        ])
        
        // Thursday UI Label
        let thursdayLabelHeight: CGFloat = 17
        thursdayLabel.textColor = textColour
        thursdayLabel.textAlignment = .center
        thursdayLabel.text = "T"
        thursdayLabel.numberOfLines = 1
        thursdayLabel.font = UIFont.systemFont(ofSize: thursdayLabelHeight, weight: .light)
        thursdayLabel.adjustsFontSizeToFitWidth = true
        thursdayLabel.minimumScaleFactor = 0.5
        thursdayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(thursdayLabel)

        NSLayoutConstraint.activate([
            thursdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0),
            thursdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth),
            thursdayLabel.leadingAnchor.constraint(equalTo: wednesdayLabel.leadingAnchor, constant: sectionWidth)
        ])
        
        // Friday UI Label
        let fridayLabelHeight: CGFloat = 17
        fridayLabel.textColor = textColour
        fridayLabel.textAlignment = .center
        fridayLabel.text = "F"
        fridayLabel.numberOfLines = 1
        fridayLabel.font = UIFont.systemFont(ofSize: fridayLabelHeight, weight: .light)
        fridayLabel.adjustsFontSizeToFitWidth = true
        fridayLabel.minimumScaleFactor = 0.5
        fridayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fridayLabel)

        NSLayoutConstraint.activate([
            fridayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0),
            fridayLabel.widthAnchor.constraint(equalToConstant: sectionWidth),
            fridayLabel.leadingAnchor.constraint(equalTo: thursdayLabel.leadingAnchor, constant: sectionWidth)
        ])
        
        
        // Saturday UI Label
        let saturdayLabelHeight: CGFloat = 17
        saturdayLabel.textColor = textColour
        saturdayLabel.textAlignment = .center
        saturdayLabel.text = "S"
        saturdayLabel.numberOfLines = 1
        saturdayLabel.font = UIFont.systemFont(ofSize: saturdayLabelHeight, weight: .light)
        saturdayLabel.adjustsFontSizeToFitWidth = true
        saturdayLabel.minimumScaleFactor = 0.5
        saturdayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(saturdayLabel)

        NSLayoutConstraint.activate([
            saturdayLabel.topAnchor.constraint(equalTo: medicationDayLabel.topAnchor, constant: 32.0),
            saturdayLabel.widthAnchor.constraint(equalToConstant: sectionWidth),
            saturdayLabel.leadingAnchor.constraint(equalTo: fridayLabel.leadingAnchor, constant: sectionWidth)
        ])
        
        // Sunday Button
        let sundayButton = BEMCheckBox(frame:CGRect(x: 0, y: 0, width: checkboxDiameter, height: checkboxDiameter))
        sundayButton.onFillColor = .blue
        sundayButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sundayButton)
        
        NSLayoutConstraint.activate([
            sundayButton.topAnchor.constraint(equalTo: sundayLabel.topAnchor, constant: sundayLabelHeight + 16.0),
            sundayButton.widthAnchor.constraint(equalToConstant: sectionWidth),
            sundayButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: offset),
        ])
        
        // Monday Button
        let mondayButton = BEMCheckBox(frame:CGRect(x: 0, y: 0, width: checkboxDiameter, height: checkboxDiameter))
        mondayButton.onFillColor = .blue
        mondayButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mondayButton)
        
        NSLayoutConstraint.activate([
            mondayButton.topAnchor.constraint(equalTo: mondayLabel.topAnchor, constant: mondayLabelHeight + 16.0),
            mondayButton.widthAnchor.constraint(equalToConstant: sectionWidth),
            mondayButton.leadingAnchor.constraint(equalTo: sundayButton.leadingAnchor, constant: sectionWidth),
        ])
        
        // Tuesday Button
        let tuesdayButton = BEMCheckBox(frame:CGRect(x: 0, y: 0, width: checkboxDiameter, height: checkboxDiameter))
        tuesdayButton.onFillColor = .blue
        tuesdayButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tuesdayButton)
        
        NSLayoutConstraint.activate([
            tuesdayButton.topAnchor.constraint(equalTo: tuesdayLabel.topAnchor, constant: tuesdayLabelHeight + 16.0),
            tuesdayButton.widthAnchor.constraint(equalToConstant: sectionWidth),
            tuesdayButton.leadingAnchor.constraint(equalTo: mondayButton.leadingAnchor, constant: sectionWidth),
        ])
        
        // Wednesday Button
        let wednesdayButton = BEMCheckBox(frame:CGRect(x: 0, y: 0, width: checkboxDiameter, height: checkboxDiameter))
        wednesdayButton.onFillColor = .blue
        wednesdayButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(wednesdayButton)
        
        NSLayoutConstraint.activate([
            wednesdayButton.topAnchor.constraint(equalTo: wednesdayLabel.topAnchor, constant: wednesdayLabelHeight + 16.0),
            wednesdayButton.widthAnchor.constraint(equalToConstant: sectionWidth),
            wednesdayButton.leadingAnchor.constraint(equalTo: tuesdayButton.leadingAnchor, constant: sectionWidth),
        ])
        
        // Thursday Button
        let thursdayButton = BEMCheckBox(frame:CGRect(x: 0, y: 0, width: checkboxDiameter, height: checkboxDiameter))
        thursdayButton.onFillColor = .blue
        thursdayButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(thursdayButton)
        
        NSLayoutConstraint.activate([
            thursdayButton.topAnchor.constraint(equalTo: thursdayLabel.topAnchor, constant: thursdayLabelHeight + 16.0),
            thursdayButton.widthAnchor.constraint(equalToConstant: sectionWidth),
            thursdayButton.leadingAnchor.constraint(equalTo: wednesdayButton.leadingAnchor, constant: sectionWidth),
        ])
        
        // Friday Button
        let fridayButton = BEMCheckBox(frame:CGRect(x: 0, y: 0, width: checkboxDiameter, height: checkboxDiameter))
        fridayButton.onFillColor = .blue
        fridayButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fridayButton)
        
        NSLayoutConstraint.activate([
            fridayButton.topAnchor.constraint(equalTo: fridayLabel.topAnchor, constant: fridayLabelHeight + 16.0),
            fridayButton.widthAnchor.constraint(equalToConstant: sectionWidth),
            fridayButton.leadingAnchor.constraint(equalTo: thursdayButton.leadingAnchor, constant: sectionWidth),
        ])
        
        // Saturday Button
        let saturdayButton = BEMCheckBox(frame:CGRect(x: 0, y: 0, width: checkboxDiameter, height: checkboxDiameter))
        saturdayButton.onFillColor = .blue
        saturdayButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(saturdayButton)
        
        NSLayoutConstraint.activate([
            saturdayButton.topAnchor.constraint(equalTo: saturdayLabel.topAnchor, constant: saturdayLabelHeight + 16.0),
            saturdayButton.widthAnchor.constraint(equalToConstant: sectionWidth),
            saturdayButton.leadingAnchor.constraint(equalTo: fridayButton.leadingAnchor, constant: sectionWidth),
        ])
        
        // Medication Time UI Label
        let medicationTimeLabelHeight: CGFloat = 20
        medicationTimeLabel.textColor = textColour
        medicationTimeLabel.textAlignment = .left
        medicationTimeLabel.text = "Medication Times"
        medicationTimeLabel.numberOfLines = 1
        medicationTimeLabel.font = UIFont.systemFont(ofSize: medicationTimeLabelHeight, weight: .regular)
        medicationTimeLabel.adjustsFontSizeToFitWidth = true
        medicationTimeLabel.minimumScaleFactor = 0.5
        medicationTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(medicationTimeLabel)

        NSLayoutConstraint.activate([
            medicationTimeLabel.topAnchor.constraint(equalTo: sundayLabel.topAnchor, constant: sundayLabelHeight + CGFloat(checkboxDiameter) + 32.0),
            medicationTimeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            medicationTimeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // Time Picker
        let timePickerHeight: CGFloat = 150
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.backgroundColor = .clear
        timePicker.timeZone = NSTimeZone.local
        timePicker.datePickerMode = .time
        
        self.view.addSubview(timePicker)
        

        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: medicationTimeLabel.topAnchor, constant: medicationTimeLabelHeight + 16.0),
            timePicker.heightAnchor.constraint(equalToConstant: timePickerHeight),
            timePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            timePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])

         // Cancel Button
         cancelButton.setTitleColor(buttonTextColour, for: .normal)
         cancelButton.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: cancelButtonHeight)
         cancelButton.backgroundColor = buttonColour
         cancelButton.layer.cornerRadius = 5
         cancelButton.setTitle("Cancel", for: .normal)
         cancelButton.translatesAutoresizingMaskIntoConstraints = false
         cancelButton.addTarget(self, action: #selector(cancelButtonFunc), for: .touchUpInside)
         self.view.addSubview(cancelButton)

         NSLayoutConstraint.activate([
             cancelButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32.0),
             cancelButton.heightAnchor.constraint(equalToConstant: cancelButtonHeight),
             cancelButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
             cancelButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
         ])
        
         // Add Medication Button
         addNewMedicationButton.setTitleColor(buttonTextColour, for: .normal)
         addNewMedicationButton.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: addNewMedicationButtonHeight)
         addNewMedicationButton.backgroundColor = buttonColour
         addNewMedicationButton.layer.cornerRadius = 5
         addNewMedicationButton.setTitle("Add New Medication", for: .normal)
         addNewMedicationButton.translatesAutoresizingMaskIntoConstraints = false
         addNewMedicationButton.addTarget(self, action: #selector(addNewMedicationButton(_:)), for: .touchUpInside)
         self.view.addSubview(addNewMedicationButton)

         NSLayoutConstraint.activate([
             addNewMedicationButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 0 - cancelButtonHeight - 16.0),
             addNewMedicationButton.heightAnchor.constraint(equalToConstant: addNewMedicationButtonHeight),
             addNewMedicationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
             addNewMedicationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
         ])
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
        medicationName = medicationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) //read the Medication Name from text field
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        //timePickerTime = dateFormatter.string(from: timePicker.date) //read the timepicker value for later use
        
        print(timePickerTime)
        
        medicationLabelAlpha = 1 //change the medicationLabel's alpha from 0 to 1 that display the medication information in sign up page
        
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
