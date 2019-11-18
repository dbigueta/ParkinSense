//-----------------------------------------------------------------
//  File: CreateAccountPageUITest.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Licheng Bao (Jerry)
//
//  Changes:
//      - Added test cases of creating account
//          1. test Create Account Success Without Medication
//          2. test Create Account Success With Medication
//          3. test create account with unvaild password (less than 6 characters)
//          4. test create account with empty infomation (name,password)
//          5. test create account with empty password
//          6. test create account with error creating
//          7. test create account with error matching (password and confirm password)
//  Known Bugs:
//      - Due to latest refactor, some test cases will not work as expected, it will be fixed in next version
//
//-----------------------------------------------------------------

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
    func testCreateAccountUIDisplay(){
        let app = XCUIApplication()
        let createAnAccount = app.buttons["Create an Account"]
        XCTAssertTrue(createAnAccount.exists)
        createAnAccount.tap()
        
        let ParkinSense = app.staticTexts["PARKINSENSE"]
        XCTAssertTrue(ParkinSense.exists)
        
        let email = app.textFields["Email"]
        XCTAssertTrue(email.exists)
        let password = app.secureTextFields["Password"]
        XCTAssertTrue(password.exists)
        
        let confirm = app.secureTextFields["Confirm Password"]
        XCTAssertTrue(confirm.exists)
        let already = app.buttons["Already have an account? Sign in"]
        XCTAssertTrue(already.exists)
        let addNewButton = app.buttons["Add New Medication Detail"]
        XCTAssertTrue(addNewButton.exists)
        let CreatButton = app.buttons["Create an Account"]
        XCTAssertTrue(CreatButton.exists)
        
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
        
        let passowrdTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passowrdTextField.exists)
        passowrdTextField.tap()
        passowrdTextField.typeText(password)
        
        
        let confrimPasswordTextField = app.secureTextFields["Confirm Password"]
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
        
        let passowrdTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passowrdTextField.exists)
        passowrdTextField.tap()
        passowrdTextField.typeText(password)
        
        
        let confrimPasswordTextField = app.secureTextFields["Confirm Password"]
        XCTAssertTrue(confrimPasswordTextField.exists)
        confrimPasswordTextField.tap()
        confrimPasswordTextField.typeText(password)
        
        
        let addNewMedicationDetailButton = app.buttons["Add New Medication Detail"]
        XCTAssertTrue(addNewMedicationDetailButton.exists)
        addNewMedicationDetailButton.tap()
        
        let addNewMedicationButton = app.buttons["Add New Medication"]
        XCTAssertTrue(addNewMedicationButton.exists)
        XCTAssertTrue(app.staticTexts["Medication Name/ID"].exists)
        XCTAssertTrue(app.staticTexts["Medication Dates"].exists)
        XCTAssertTrue(app.staticTexts["Medication Times"].exists)
        
        
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
        let error = "Password must be at least 6 characters"
        
        
        let app = XCUIApplication()
        let createAnAccountButton = app.buttons["Create an Account"]
        createAnAccountButton.tap()
        
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passowrdTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passowrdTextField.exists)
        passowrdTextField.tap()
        passowrdTextField.typeText(password)
        
        
        let confrimPasswordTextField = app.secureTextFields["Confirm Password"]
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
        let error = "User Account should be valid email address"
        
        
        let app = XCUIApplication()
        let createAnAccountButton = app.buttons["Create an Account"]
        createAnAccountButton.tap()
        
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passowrdTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passowrdTextField.exists)
        passowrdTextField.tap()
        passowrdTextField.typeText(password)
        
        
        let confrimPasswordTextField = app.secureTextFields["Confirm Password"]
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
        let error =   "Passwords do not match. Please re-enter your password."
        
        
        let app = XCUIApplication()
        let createAnAccountButton = app.buttons["Create an Account"]
        createAnAccountButton.tap()
        
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passowrdTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passowrdTextField.exists)
        passowrdTextField.tap()
        passowrdTextField.typeText(password)
        
        
        let confrimPasswordTextField = app.secureTextFields["Confirm Password"]
        XCTAssertTrue(confrimPasswordTextField.exists)
        confrimPasswordTextField.tap()
        confrimPasswordTextField.typeText(confirm)
        
        createAnAccountButton.tap()
        XCTAssertTrue(app.staticTexts[error].exists)
        
        
        
        //app.alerts["Reminder"].buttons["OK"].tap()
    }

}
