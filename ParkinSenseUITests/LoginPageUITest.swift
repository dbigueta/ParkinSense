//-----------------------------------------------------------------
//  File: LoginPageUITest.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Licheng Bao (Jerry)
//
//  Changes:
//      - Added test cases of login page
//          1. Test login successfully
//          2. Test login with empty name
//          3. Test login with empty password
//          4. Test login with empty name and password
//          5. Test login with unformatted name
//          6. Test login with non-exist account
//
//  Known Bugs:
//      - Due to latest refactor, some test cases will not work as expected, it will be fixed in next version
//
//-----------------------------------------------------------------
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
    
    func testLoginPageUIDisplay(){
        let app = XCUIApplication()
        let createAnAccount = app.buttons["Create an Account"]
        XCTAssertTrue(createAnAccount.exists)
        
        
        let ParkinSense = app.staticTexts["PARKINSENSE"]
        XCTAssertTrue(ParkinSense.exists)
        
        let email = app.textFields["Email"]
        XCTAssertTrue(email.exists)
        let password = app.secureTextFields["Password"]
        XCTAssertTrue(password.exists)
        
        
       
        let SparkYourSense = app.staticTexts["SPARK YOUR SENSES"]
        XCTAssertTrue(SparkYourSense.exists)
        
        let remeberPassword = app.staticTexts["Remember Password"]
        XCTAssertTrue(remeberPassword.exists)
        
       // let uncheckboxButton = app.buttons["uncheckbox"]
        //XCTAssertTrue(uncheckboxButton.exists)
        
        //let orButton = app.staticTexts["OR"]
        //XCTAssertTrue(orButton.exists)
        let signinButton = app.buttons["Sign In"]
        XCTAssertTrue(signinButton.exists)
        
        
        
    }

    func testLoginSuccess(){
        
        let userName = "sgnb@t.com"
        let password = "ywwuyi"
        
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["Email"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passwordTextField = app.secureTextFields["Password"]
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
        
        
        
        let passwordTextField = app.secureTextFields["Password"]
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
        
        
        let signIn = app.buttons["Sign In"]
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
        
        
        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        let signIn = app.buttons["Sign In"]
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
        
        let passwordTextField = app.secureTextFields["Password"]
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
        
        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        //app.buttons["uncheckbox"].tap()
        let signIn = app.buttons["Sign In"]
        XCTAssertTrue(signIn.exists)
        signIn.tap()
        sleep(3)
        XCTAssertTrue(app.staticTexts[error].exists)
        //Not pass
        // Too much time for responsing
    }

}
