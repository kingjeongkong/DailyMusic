//
//  HomeViewModelTests.swift
//  HomeViewModelTests
//
//  Created by 왕정빈 on 9/6/24.
//

import XCTest
import RxSwift
import RxCocoa
@testable import DailyMusic

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockFeeduseCase: MockFeedUseCase!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockFeeduseCase = MockFeedUseCase()
        viewModel = HomeViewModel(feedUseCase: mockFeeduseCase)
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        mockFeeduseCase = nil
        viewModel = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
    
    func test_getFeeds_emitsFeeds() {
        // Given
        let expectedFeeds = [Feed(caption: "Test Feed",
                                  imageURL: "http://example.com/image.jpg",
                                  timestamp: Date())]
        mockFeeduseCase.mockFeeds = expectedFeeds
        
        // When
        let input = HomeViewModel.Input(refreshEvent: Observable.just(()))
        let output = viewModel.transform(input: input)
        
        // Then
        let expectation = XCTestExpectation(description: "Feeds emitted")
        output.feeds
            .drive { feeds in
                XCTAssertEqual(feeds, expectedFeeds)
                expectation.fulfill()
            }
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getFeeds_whenError_emitsError() {
        // Given
        mockFeeduseCase.shouldReturnError = true
        
        // When
        let input = HomeViewModel.Input(refreshEvent: Observable.just(()))
        let output = viewModel.transform(input: input)
        
        // Then
        let expectation = XCTestExpectation(description: "Error emitted")
        output.errorMessage
            .drive { errorMessage in
                XCTAssertEqual(errorMessage, "Failed to fetch feeds: Mock error occurred")
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
