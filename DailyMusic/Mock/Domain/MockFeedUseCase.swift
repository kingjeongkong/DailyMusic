//
//  MockFeedUseCase.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/23/24.
//

import Foundation
import RxSwift

final class MockFeedUseCase: FeedUseCase {
    var mockFeeds: [Feed] = []
    var shouldReturnError = false
    
    init() {
        super.init(feedRepository: MockFeedRepository())
    }
    
    override func getFeed() -> Single<[Feed]> {
        if shouldReturnError {
            return Single.error(NSError(domain: "Test Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error occurred"]))
        } else {
            return Single.just(mockFeeds)
        }
    }
}
