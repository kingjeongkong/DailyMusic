//
//  DailyMusicUITests.swift
//  DailyMusicUITests
//
//  Created by 왕정빈 on 9/6/24.
//

//import XCTest
//
//final class HomeViewUITests: XCTestCase {
//    var app: XCUIApplication!
//
//    override func setUpWithError() throws {
//        continueAfterFailure = false
//        app = XCUIApplication()
//        app.launchArguments = ["-UITest"]
//        app.launch()
//    }
//
//    override func tearDownWithError() throws {
//        app = nil
//    }
//
//    func test_homeView_showsCorrectUIElements() {
//        XCTAssertTrue(app.navigationBars["EndYourDay"].exists)
//        XCTAssertTrue(app.buttons["plus"].exists)
//        XCTAssertTrue(app.collectionViews["homeCollectionView"].exists)
//    }
//
//    func test_plusButton_opensAddFeedViewController() {
//        let plusButton = app.buttons["plus"]
//        XCTAssertTrue(plusButton.exists)
//
//        plusButton.tap()
//
//        XCTAssertTrue(app.navigationBars["Add Feed"].exists)
//    }
//
//    func test_pullToRefresh_updatesFeeds() {
//        let collectionView = app.collectionViews["homeCollectionView"]
//        XCTAssertTrue(collectionView.exists)
//
//        collectionView.swipeDown()
//
//        let firstCell = collectionView.cells.element(boundBy: 0)
//        XCTAssertTrue(firstCell.exists)
//        XCTAssertTrue(firstCell.staticTexts["Test Caption"].exists)
//    }
//}
