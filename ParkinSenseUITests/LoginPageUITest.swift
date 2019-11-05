//
//  LoginPageUITest.swift
//  ParkinSense-12.4UITests
//
//  Created by 包立诚 on 2019/11/3.
//  Copyright © 2019 PDD Inc. All rights reserved.
//

import XCTest

class LoginPageUITest: XCTestCase {

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

    func testLoginSuccess(){
        
        let userName = "sgnb@t.com"
        let password = "ywwuyi"
        
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passwordTextField = app.textFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        app.buttons["uncheckbox"].tap()
        
        let signIn = app.buttons["Sign in"]
        XCTAssertTrue(signIn.exists)
        signIn.tap()
        //app.alerts["Reminder"].buttons["OK"].tap()
    }
    
    func testLoginEmptyName(){
        
        let app = XCUIApplication()
        
        let password = "123321"
        let error = "The email address is badly formatted."
        
        
        
        let passwordTextField = app.textFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        
        app.buttons["uncheckbox"].tap()
        
        
        let signIn = app.buttons["Sign in"]
        XCTAssertTrue(signIn.exists)
        signIn.tap()
        //Not occur
        
        XCTAssertTrue(app.staticTexts[error].exists)
        
        
        
        
    }
    
    func testLoginEmptyPassword(){
        
        let username = "guten@b.com"
        let error = "The password is invalid or the user does not have a password."
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(username)
        //        let passwordTextField = app.textFields["   Password"]
        //        XCTAssertTrue(passwordTextField.exists)
        //        passwordTextField.tap()
        
        
        let signIn = app.buttons["Sign in"]
        XCTAssertTrue(signIn.exists)
        signIn.tap()
        
        
        
        
        
        XCTAssertTrue(app.staticTexts[error].exists)
        
        
        
    }
    
    func testLoginEmptyNameAndPassword(){
        
        let error = "The password is invalid or the user does not have a password."
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        //usertext.typeText("sfgdfr")
        
        
        let passwordTextField = app.textFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        let signIn = app.buttons["Sign in"]
        XCTAssertTrue(signIn.exists)
        signIn.tap()
        
        XCTAssertTrue(app.staticTexts[error].exists)
        //app.staticTexts["The password is invalid or the user does not have a password."].tap()
        
        
        
        
        
    }
    
    func testLoginUnformattedName(){
        
        let userName = "guten"
        let password = "123321"
        let error = "The email address is badly formatted."
        
        
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passwordTextField = app.textFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        app.buttons["uncheckbox"].tap()
        let signIn = app.buttons["Sign in"]
        XCTAssertTrue(signIn.exists)
        signIn.tap()
        
        
        XCTAssertTrue(app.staticTexts[error].exists)
        
    }
    
    func testLoginNonExistName(){
        
        let userName = "aabbcc@g.com"
        //let password = "12332112121212"
        let password = "123"
        let error = "There is no user record corresponding to this identifier. The user may have been deleted."
        
        
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passwordTextField = app.textFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        app.buttons["uncheckbox"].tap()
        let signIn = app.buttons["Sign in"]
        XCTAssertTrue(signIn.exists)
        signIn.tap()
        
        XCTAssertTrue(app.staticTexts[error].exists)
        //Not pass
        // Too much time for responsing
    }

}
