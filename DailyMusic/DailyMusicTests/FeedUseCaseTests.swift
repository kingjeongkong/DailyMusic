//
//  FeedUseCaseTests.swift
//  DailyMusicTests
//
//  Created by 왕정빈 on 9/23/24.
//

import XCTest
import RxSwift
@testable import DailyMusic

final class FeedUseCaseTests: XCTestCase {
    var feedUseCase: FeedUseCase!
    var mockRepository: MockFeedRepository!
    var disposeBag: DisposeBag!

    override func setUp() {
        super .setUp()
        mockRepository = MockFeedRepository()
        feedUseCase = FeedUseCase(feedRepository: mockRepository)
        disposeBag = DisposeBag()
    }
    
    func test_feedUsecCase_getFeed() {
        //Given
        let expectedFeeds = [Feed(caption: "Test",
                                  imageURL: "http://example.com/image.jpg",
                                  timestamp: Date())]
        mockRepository.mockFeeds = expectedFeeds
        
        //When
        let expectation = XCTestExpectation(description: "Get Feeds")
        feedUseCase.getFeed()
            .subscribe { feeds in
                //Then
                XCTAssertEqual(feeds, expectedFeeds)
                
                expectation.fulfill()
            } onFailure: { error in
                XCTFail("Error : \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_feedUsecCase_uploadFeed() {
        //Given
        let testFeed = Feed(caption: "New Feed",
                            imageURL: nil,
                            timestamp: nil)
        let testImage = UIImage()
        let expectedimageURL = "http://example.com/image.jpg"
        mockRepository.mockImageURL = expectedimageURL
        
        //When
        let expectation = XCTestExpectation(description: "Upload Feed")
        feedUseCase.uploadFeed(feed: testFeed, image: testImage)
            .subscribe { _ in
                XCTAssertTrue(self.mockRepository.isUploadFeedCalled)
                XCTAssertTrue(self.mockRepository.isUploadImageCalled)
                
                XCTAssertEqual(self.mockRepository.mockImageURL, expectedimageURL, "Image URL should match the expected value.")
                
                expectation.fulfill()
            } onFailure: { error in
                XCTFail("Error : \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 1.0)
    }
}
