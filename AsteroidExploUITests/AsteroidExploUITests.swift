//
//  AsteroidExploUITests.swift
//  AsteroidExploUITests
//
//  Created by user260596 on 9/27/25.
//
import XCTest

final class AsteroidExploUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testTapAsteroidRowShowsDetail() {
        let app = XCUIApplication()
        let scrollView = app.scrollViews.firstMatch
            
            // Tap the first row
            let firstRow = scrollView.children(matching: .other).element(boundBy: 0)
            XCTAssertTrue(firstRow.exists, "First asteroid row should exist")
            firstRow.tap()
            
            // Wait for the detail screen to appear
            let detailText = app.staticTexts.firstMatch
            XCTAssertTrue(detailText.waitForExistence(timeout: 5), "Detail screen should appear after tapping row")
        }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
