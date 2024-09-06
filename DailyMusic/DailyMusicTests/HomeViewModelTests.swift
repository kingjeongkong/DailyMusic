//
//  HomeViewModelTests.swift
//  HomeViewModelTests
//
//  Created by 왕정빈 on 9/6/24.
//

import XCTest
import FirebaseCore
@testable import DailyMusic

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_GetDataSuccessfully() {
        let expectation = self.expectation(description: "Get Feeds Successfully")
        
        viewModel.getData { feeds in
            XCTAssertNotNil(feeds)
            XCTAssertTrue(feeds.count > 0, "Feeds should be got successfully.")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { _ in
            print("Time Out")
        }
    }
}
