//
//  CreateAccountPageUITest.swift
//  ParkinSense-12.4UITests
//
//  Created by 包立诚 on 2019/11/3.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

import XCTest

class CreateAccountPageUITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateAccountSuccessWithoutMedication(){
        
        let userName = "guten@s.com"
        let password = "123321"
        
        
        let app = XCUIApplication()
        let createAnAccountButton = app.buttons["Create an Account"]
        createAnAccountButton.tap()
        
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passowrdTextField = app.textFields["Password"]
        XCTAssertTrue(passowrdTextField.exists)
        passowrdTextField.tap()
        passowrdTextField.typeText(password)
        
        
        let confrimPasswordTextField = app.textFields["Confirm Password"]
        XCTAssertTrue(confrimPasswordTextField.exists)
        confrimPasswordTextField.tap()
        confrimPasswordTextField.typeText(password)
        
        createAnAccountButton.tap()
        //app.alerts["Reminder"].buttons["OK"].tap()
    }
    
    func testCreateAccountSuccessWithMedication(){
        
        let userName = "guten@s.com"
        let password = "123321"
        
        
        let app = XCUIApplication()
        let createAnAccountButton = app.buttons["Create an Account"]
        createAnAccountButton.tap()
        
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passowrdTextField = app.textFields["Password"]
        XCTAssertTrue(passowrdTextField.exists)
        passowrdTextField.tap()
        passowrdTextField.typeText(password)
        
        
        let confrimPasswordTextField = app.textFields["Confirm Password"]
        XCTAssertTrue(confrimPasswordTextField.exists)
        confrimPasswordTextField.tap()
        confrimPasswordTextField.typeText(password)
        
        
        let addNewMedicationDetailButton = app.buttons["Add New Medication Detail"]
        XCTAssertTrue(addNewMedicationDetailButton.exists)
        addNewMedicationDetailButton.tap()
        
        let addNewMedicationButton = app.buttons["Add New Medication"]
        XCTAssertTrue(addNewMedicationButton.exists)
        XCTAssertTrue(app.staticTexts["Medication Name"].exists)
        XCTAssertTrue(app.staticTexts["Medication Time & Date"].exists)
        
        
        let mcircleButton = app.buttons["Mcircle"]
        mcircleButton.tap()
        
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        let scircleButton = element.children(matching: .button).matching(identifier: "Scircle").element(boundBy: 0)
        scircleButton.tap()
        mcircleButton.tap()
        mcircleButton.tap()
        scircleButton.tap()
        mcircleButton.tap()
        scircleButton.tap()
        scircleButton.tap()
        
        let wcircleButton = app.buttons["Wcircle"]
        wcircleButton.tap()
        wcircleButton.tap()
        
        let tcircleButton = element.children(matching: .button).matching(identifier: "Tcircle").element(boundBy: 0)
        tcircleButton.tap()
        tcircleButton.tap()
        
        
        
        
        
        addNewMedicationDetailButton.tap()
        
        let medicationNameTextField = app.textFields["Medication Name"]
        XCTAssertTrue(medicationNameTextField.exists)
        medicationNameTextField.tap()
        addNewMedicationButton.tap()
        app.staticTexts["ssh"].tap()
        addNewMedicationDetailButton.tap()
        medicationNameTextField.tap()
        addNewMedicationButton.tap()
        app.staticTexts["ggg"].tap()
        app.buttons["Create an Account"].tap()
        createAnAccountButton.tap()
        app.alerts["Reminder"].buttons["OK"].tap()
    }
    
    /*
     Test TODO:
     1. Add multiple medication details.
     Expected: when input second or more medication details, it should not replace the first or previous medication info
     2. After adding the medication info, it should not emtpy the "confirm password"
     3. When we create an account with exist info, error should tell user why
     
     */
    
    func testCreateAccountUnvaildPassword(){
        let userName = "guten@s.com"
        let password = "1551"
        let error = "Password must be at least 6 characters."
        
        
        let app = XCUIApplication()
        let createAnAccountButton = app.buttons["Create an Account"]
        createAnAccountButton.tap()
        
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passowrdTextField = app.textFields["Password"]
        XCTAssertTrue(passowrdTextField.exists)
        passowrdTextField.tap()
        passowrdTextField.typeText(password)
        
        
        let confrimPasswordTextField = app.textFields["Confirm Password"]
        XCTAssertTrue(confrimPasswordTextField.exists)
        confrimPasswordTextField.tap()
        confrimPasswordTextField.typeText(password)
        
        createAnAccountButton.tap()
        XCTAssertTrue(app.staticTexts[error].exists)
        
    }
    
    func testCreateAccountEmptyAll(){
        //        let userName = "guten@s.com"
        //        let password = "1551"
        let error = "Please fill in all fields."
        
        
        let app = XCUIApplication()
        let createAnAccountButton = app.buttons["Create an Account"]
        createAnAccountButton.tap()
        //
        //        let usernameTextField = app.textFields["   User Account"]
        //        XCTAssertTrue(usernameTextField.exists)
        //        usernameTextField.tap()
        //        usernameTextField.typeText(userName)
        //
        //        let passowrdTextField = app.textFields["   Password"]
        //        XCTAssertTrue(passowrdTextField.exists)
        //        passowrdTextField.tap()
        //        passowrdTextField.typeText(password)
        //
        //
        //        let confrimPasswordTextField = app.textFields["   Confirm Password"]
        //        XCTAssertTrue(confrimPasswordTextField.exists)
        //        confrimPasswordTextField.tap()
        //        confrimPasswordTextField.typeText(password)
        
        createAnAccountButton.tap()
        XCTAssertTrue(app.staticTexts[error].exists)
    }
    
    func testCreateAccountEmptyPassword(){
        let userName = "guten@s.com"
        //let password = "1551"
        let error = "Please fill in all fields."
        
        
        let app = XCUIApplication()
        let createAnAccountButton = app.buttons["Create an Account"]
        createAnAccountButton.tap()
        //
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        //
        //        let passowrdTextField = app.textFields["   Password"]
        //        XCTAssertTrue(passowrdTextField.exists)
        //        passowrdTextField.tap()
        //        passowrdTextField.typeText(password)
        //
        //
        //        let confrimPasswordTextField = app.textFields["   Confirm Password"]
        //        XCTAssertTrue(confrimPasswordTextField.exists)
        //        confrimPasswordTextField.tap()
        //        confrimPasswordTextField.typeText(password)
        
        createAnAccountButton.tap()
        XCTAssertTrue(app.staticTexts[error].exists)
    }
    
    func testCreateAccountErrorCreating(){
        
        let userName = "guten@s.com"
        let password = "123321"
        let error = "Error creating user"
        
        
        let app = XCUIApplication()
        let createAnAccountButton = app.buttons["Create an Account"]
        createAnAccountButton.tap()
        
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passowrdTextField = app.textFields["Password"]
        XCTAssertTrue(passowrdTextField.exists)
        passowrdTextField.tap()
        passowrdTextField.typeText(password)
        
        
        let confrimPasswordTextField = app.textFields["Confirm Password"]
        XCTAssertTrue(confrimPasswordTextField.exists)
        confrimPasswordTextField.tap()
        confrimPasswordTextField.typeText(password)
        createAnAccountButton.tap()
        sleep(3)
        XCTAssertTrue(app.staticTexts[error].exists)
        
    }
    
    func testCreateAccountErrorMatching(){
        
        let userName = "guten@s.com"
        let password = "123321"
        let confirm = "1233"
        let error =   "Pleace make sure the password is matched"
        
        
        let app = XCUIApplication()
        let createAnAccountButton = app.buttons["Create an Account"]
        createAnAccountButton.tap()
        
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passowrdTextField = app.textFields["Password"]
        XCTAssertTrue(passowrdTextField.exists)
        passowrdTextField.tap()
        passowrdTextField.typeText(password)
        
        
        let confrimPasswordTextField = app.textFields["Confirm Password"]
        XCTAssertTrue(confrimPasswordTextField.exists)
        confrimPasswordTextField.tap()
        confrimPasswordTextField.typeText(confirm)
        
        createAnAccountButton.tap()
        XCTAssertTrue(app.staticTexts[error].exists)
        
        
        
        //app.alerts["Reminder"].buttons["OK"].tap()
    }

}
