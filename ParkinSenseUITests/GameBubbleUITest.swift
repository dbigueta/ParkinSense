//-----------------------------------------------------------------
//  File: GameTiltUITest.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Licheng Bao (Jerry)
//
//  Changes:
//      - Added test cases of Game Tilt UI
//
//  Known Bugs:
//      - Due to latest refactor, some test cases will not work as expected, it will be fixed in next version
//
//-----------------------------------------------------------------

import XCTest

class GameBubbleUITest: XCTestCase {

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

    func testBubbleUIDisplay() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testBubbleQuit(){
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //login part
       
        let userName = "test@t.com"
        let password = "123456"
        
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
        app.buttons["Sign in"].tap()
        //app.alerts["Reminder"].buttons["OK"].tap()
        
        //main UI part
        //let app = XCUIApplication()
        //app.alerts["Reminder"].buttons["OK"].tap()
        let scrollViewsQuery = app.scrollViews
        let WeeklyProgress = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Weekly Progress").element
        
        WeeklyProgress/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        WeeklyProgress.swipeDown()
        
        //Game Bubble Pop UI
        let bubbleButton = scrollViewsQuery.otherElements.buttons["Bubble Pop"]
        XCTAssertTrue(bubbleButton.exists)
        bubbleButton.tap()
        app.buttons["Quit"].tap()
        
    }
    
    func testBubbleStart(){
        // Use recording to get started writing UI tests.
            // Use XCTAssert and related functions to verify your tests produce the correct results.
            //login part
            let userName = "test@t.com"
            let password = "123456"
            
            
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
            app.buttons["Sign in"].tap()
            
            //main UI part
            let scrollViewsQuery = app.scrollViews
            let WeeklyProgress = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Weekly Progress").element
            
            WeeklyProgress/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            WeeklyProgress.swipeDown()
            
            //Game Bubble pop UI
            let bubbleButton = scrollViewsQuery.otherElements.buttons["Bubble Pop"]
            XCTAssertTrue(bubbleButton.exists)
            bubbleButton.tap()
            
                 
            
            
            //Game Tilt Part
            app.buttons["Start"].tap()
            
            
            sleep(6)
            
        
                
            
    }
    

}
