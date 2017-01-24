//
//  Mundus_iosUITests.swift
//  Mundus_iosUITests
//
//  Created by Stephan on 19/12/2016.
//  Copyright © 2016 Stephan. All rights reserved.
//

import XCTest

class Mundus_iosUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments = ["MY_UI_TEST_MODE"]
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateGame() {
        
        let app = XCUIApplication()
        let enterAUsernameTextField = app.textFields["Enter a username"]
        enterAUsernameTextField.tap()
        enterAUsernameTextField.typeText("sasa")
        app.buttons["Start Game"].tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Publications"].tap()
        tabBarsQuery.buttons["Question feed"].tap()
        tabBarsQuery.buttons["Sources"].tap()
        
    }
    
    func testDeleteGame(){
        
        let app = XCUIApplication()
        let enterAUsernameTextField = app.textFields["Enter a username"]
        enterAUsernameTextField.tap()
        enterAUsernameTextField.typeText("dada")
        app.buttons["Start Game"].tap()
        app.buttons["Delete"].tap()
        
    }
    
    func testPauseGame() {
        
        let app = XCUIApplication()
        let enterAUsernameTextField = app.textFields["Enter a username"]
        enterAUsernameTextField.tap()
        enterAUsernameTextField.typeText("ddd")
        app.buttons["Start Game"].tap()
        
        let pauseButton = app.buttons["Pause"]
        pauseButton.tap()
        pauseButton.tap()
        pauseButton.tap()
        pauseButton.tap()
        
    }
    
    func testGameNoName() {
        
        let app = XCUIApplication()
        app.textFields["Enter a username"].tap()
        
        let startGameButton = app.buttons["Start Game"]
        startGameButton.tap()
        startGameButton.tap()
        
    }
    
    func testJoinNoName() {
        XCUIDevice.shared().orientation = .portrait
        
        let joinGameButton = XCUIApplication().buttons["Join Game"]
        joinGameButton.tap()
        joinGameButton.tap()

        
    }
    
    
}
