//-----------------------------------------------------------------
//  File: GameTiltUITest.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Licheng Bao (Jerry)
//
//  Changes:
//      - Added test cases of Game Tilt UI
//          1. Test quiting the game
//          2. Test entering the game
//
//  Known Bugs:
//      - Due to latest refactor, some test cases will not work as expected, it will be fixed in next version
//
//-----------------------------------------------------------------

import XCTest

class GameTiltUITest: XCTestCase {

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

    func testGameQuit() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //login part
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
        app.buttons["Sign in"].tap()
        
        //main UI part
        //let app = XCUIApplication()
        //app.alerts["Reminder"].buttons["OK"].tap()
        let scrollViewsQuery = app.scrollViews
        let page1Of2Element = scrollViewsQuery.otherElements.containing(.pageIndicator, identifier:"page 1 of 2").element
        
        page1Of2Element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        page1Of2Element.swipeDown()
        page1Of2Element.swipeUp()
        scrollViewsQuery.otherElements.buttons["GameOne"].tap()
        
        //Game Tilt UI
        
        app.buttons["Quit"].tap()
        
    }
    
    func testGameStart() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //login part
        let userName = "sgnb@t.com"
        let password = "ywwuyi"
        
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["   User Account"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(userName)
        
        let passwordTextField = app.textFields["   Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        app.buttons["uncheckbox"].tap()
        app.buttons["Sign in"].tap()
        
        //main UI part
        let scrollViewsQuery = app.scrollViews
        let page1Of2Element = scrollViewsQuery.otherElements.containing(.pageIndicator, identifier:"page 1 of 2").element
        
        page1Of2Element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        page1Of2Element.swipeDown()
        page1Of2Element.swipeUp()
        scrollViewsQuery.otherElements.buttons["GameOne"].tap()
        
        //Game Tilt Part
        app.buttons["Start"].tap()
        
        
        sleep(6)
        
        //        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        //        //element/*@START_MENU_TOKEN@*/.press(forDuration: 1.9);/*[[".tap()",".press(forDuration: 1.9);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        //
        //        for _ in 1...10 {
        //            element.swipeRight()
        //        }
        //        for _ in 1...10 {
        //            element.swipeUp()
        //        }
        //        for _ in 1...10 {
        //            element.swipeLeft()
        //        }
        //        for _ in 1...10 {
        //            element.swipeDown()
        //        }
        //
        //        element/*@START_MENU_TOKEN@*/.press(forDuration: 2.0);/*[[".tap()",".press(forDuration: 2.0);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        
    }

}
