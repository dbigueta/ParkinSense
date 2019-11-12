//-----------------------------------------------------------------
//  File: MedicationDetailViewController.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Higgins Weng
//
//  Description: Main view of the medication page - allows registration of new medication
//
//  Changes:
//      - Check the time picker time zone
//      - Add the Medicaiton name to Firebase
//
//  Known Bugs:
//      - Need to put the time picker time to Signup page
//
//-----------------------------------------------------------------

import UIKit

class MedicationDetailViewController: UIViewController {
    
    @IBOutlet weak var medicationTextField: UITextField!
    
    @IBOutlet var dateSelectionButtons: [UIButton]!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var addNewMedicationButton: UIButton!
    
    var isDateSelect: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timePicker?.datePickerMode = .time
        
        timePicker.timeZone = NSTimeZone.local
        
        setUpElements()
    }
    

    /**
        Function for set up the appearance of the medication detail page
     
         - Returns: None
    **/
    func setUpElements(){
        Utilities.styleFilledButton(addNewMedicationButton)
    }
    
    
    /**
        Function to change the appearance of the day buttons when tapped
     
         - Parameter sender: Button itself
         - Returns: None
    **/
    @IBAction func dateSelectionTapped(_ sender: UIButton) {
        isDateSelect.toggle()
        
        if isDateSelect{
            sender.tintColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        }
        else{
            sender.tintColor = UIColor.init(red: 169/255, green: 170/255, blue: 171/255, alpha: 1)
        }
    }
    
    
    /**
        Function about the add new medication Button, will direct you back to the sign up page and medication will be displayed on the screen
     
         - Parameter sender: Button itself
     
         - Returns: No
            
    **/
    @IBAction func addNewMedicationButton(_ sender: Any) {
        medicationName = medicationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) //read the Medication Name from text field
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        timePickerTime = dateFormatter.string(from: timePicker.date) //read the timepicker value for later use
        
        print(timePickerTime)
        
        medicationLabelAlpha = 1 //change the medicationLabel's alpha from 0 to 1 that display the medication information in sign up page
    }
}
