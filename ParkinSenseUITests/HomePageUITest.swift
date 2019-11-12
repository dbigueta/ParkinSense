//-----------------------------------------------------------------
//  File: HomePageUITest.swift
//
//  Team: ParkinSense - PDD Inc.
//
//  Programmer(s): Licheng Bao (Jerry)
//
//  Changes:
//      - Added test cases of home page
//          1. Test scrolling up and down of whole home page
//          2. test swipe trendline and daily data
//          3. Test week buttons and "prev" "next" button
//
//  Known Bugs:
//      - Due to latest refactor, some test cases will not work as expected, it will be fixed in next version
//
//-----------------------------------------------------------------

import XCTest

class HomePageUITest: XCTestCase {

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

    func testMainUI_Scroll() {
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
        //app.alerts["Reminder"].buttons["OK"].tap()
        
        //main UI part
        //let app = XCUIApplication()
        //app.alerts["Reminder"].buttons["OK"].tap()
        let scrollViewsQuery = app.scrollViews
        let page1Of2Element = scrollViewsQuery.otherElements.containing(.pageIndicator, identifier:"page 1 of 2").element
        
        page1Of2Element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        page1Of2Element.swipeDown()
        page1Of2Element.swipeUp()
        
        page1Of2Element.swipeUp()
        
        
        
    }
    
    func testMainUI_Swipe() {
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
        //app.alerts["Reminder"].buttons["OK"].tap()
        
        //main UI part
        //let app = XCUIApplication()
        //app.alerts["Reminder"].buttons["OK"].tap()
        
        let elementsQuery = XCUIApplication().scrollViews.otherElements
        let appiconScrollView = elementsQuery.scrollViews.containing(.image, identifier:"AppIcon").element
        appiconScrollView.tap()
        appiconScrollView.swipeLeft()
        
        
        let iMATestLabelStaticText = elementsQuery.staticTexts["I'm a test label"]
        XCTAssertTrue(iMATestLabelStaticText.exists)
        
        iMATestLabelStaticText.swipeRight()
        
    }
    
    func testMainUI_weekButtons(){
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
        //app.alerts["Reminder"].buttons["OK"].tap()
        
        //main UI part
        let elementsQuery = app.scrollViews.otherElements
        let prevButton = elementsQuery.buttons["< Prev."]
        let nextButton = elementsQuery.buttons["Next >"]
        
        //        let week9 = elementsQuery.staticTexts["10/27 ~ 11/02"]
        //        let week10 = elementsQuery.staticTexts["11/03 ~ 11/09"]
        //        let week11 = elementsQuery.staticTexts["11/10 ~ 11/16"]
        
        
        
        
        //        XCTAssertTrue(week10.exists)
        prevButton.tap()
        //        XCTAssertTrue(week9.exists)
        nextButton.tap()
        //        XCTAssertTrue(week10.exists)
        nextButton.tap()
        
        
        //        elementsQuery.buttons["03"].tap()
        //        elementsQuery.buttons["06"].tap()
        
        
    }

}
