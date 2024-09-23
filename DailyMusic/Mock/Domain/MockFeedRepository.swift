//
//  MockFeedRepository.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/22/24.
//

import UIKit
import RxSwift

final class MockFeedRepository: FeedRepository {
    
    var mockFeeds: [Feed] = []
    var mockImageURL = ""
    var isUploadImageCalled = false
    var isUploadFeedCalled = false
    
    func getFeed() -> RxSwift.Single<[Feed]> {
        return Single.just(mockFeeds)
    }
    
    func uploadImage(image: UIImage) -> RxSwift.Single<String> {
        isUploadImageCalled = true
        return Single.just(mockImageURL)
    }
    
    func uploadFeed(feed: Feed) -> RxSwift.Single<Void> {
        isUploadFeedCalled = true
        return Single.just(())
    }
}
