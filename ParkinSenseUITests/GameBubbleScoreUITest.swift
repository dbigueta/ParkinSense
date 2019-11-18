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

class GameBubbleScoreUITest: XCTestCase {

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

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
