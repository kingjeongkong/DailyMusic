//
//  DailyMusicUITests.swift
//  DailyMusicUITests
//
//  Created by 왕정빈 on 9/6/24.
//

import XCTest

final class HomeViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // UI 테스트를 시작하기 전에 설정 코드 작성
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()  // 앱을 실행
    }

    func test_CollectionViewDataLoadsCorrectly() {
        // UI 요소 정의
        let collectionView = app.collectionViews["homeCollectionView"]
        
        // Collection View 셀의 개수 확인 (데이터가 로드되었을 때)
        XCTAssertTrue(collectionView.cells.count > 0, "Collection View should have cells after data is loaded.")
    }
    
    // TODO : feed 추가된 후 CollectionView에 반영되는지 Test
//    func test_CollectionViewUpdatesAfterFeedAdded() {
//        // HomeView 화면이 로드되었는지 확인
//        let collectionView = app.collectionViews["homeCollectionView"]
//        XCTAssertTrue(collectionView.exists, "HomeViewController's collection view should exist.")
//
//        // 초기 피드 데이터 개수 확인
//        let initialCellCount = collectionView.cells.count
//        XCTAssertGreaterThan(initialCellCount, 0, "There should be some initial feeds loaded in the collection view.")
//
//        // 1. 새로운 피드 추가 플로우 시뮬레이션
//        let addFeedButton = app.navigationBars.buttons["plus"]
//        XCTAssertTrue(addFeedButton.exists, "Add feed button should exist.")
//        addFeedButton.tap()
//
//        // 이미지 선택 화면에서 앨범 이미지 선택 대기
//        let imageView = app.images["albumImageView"]
//        XCTAssertTrue(imageView.exists, "Album image view should exist.")
//        imageView.tap()
//
//        // 미리 설정된 캡션 텍스트 사용
//        let captionTextField = app.textFields["captionTextField"]
//        XCTAssertEqual(captionTextField.value as? String, "New Test Caption", "Caption text field should have the preset text.")
//
//        // 피드 추가 버튼 클릭
//        let shareButton = app.navigationBars.buttons["공유"]
//        XCTAssertTrue(shareButton.exists, "Share button should exist.")
//        shareButton.tap()
//
//        // NotificationCenter를 통해 업데이트 기다림
//        let expectation1 = XCTNSNotificationExpectation(name: NSNotification.Name("FeedUploaded"))
//        let result1 = XCTWaiter().wait(for: [expectation1], timeout: 30)  // 조금 더 여유 있게 대기 시간을 설정
//        XCTAssertEqual(result1, .completed, "CollectionView should be updated with new feeds.")
//
//        // 4. 업데이트된 셀 개수 확인
//        let updatedCellCount = collectionView.cells.count
//        XCTAssertGreaterThan(updatedCellCount, initialCellCount, "The number of cells should increase after a new feed is added.")
//    }
}
