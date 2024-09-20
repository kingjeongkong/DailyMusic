//
//  GetFeedUseCase.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/9/24.
//

import UIKit
import RxSwift

final class FeedUseCase {
    private let feedRepository: FeedRepository
    
    init(feedRepository: FeedRepository) {
        self.feedRepository = feedRepository
    }
    
    func getFeed() -> Single<[Feed]> {
        return feedRepository.getFeed()
    }
    
    func uploadFeed(feed: Feed, image: UIImage) -> Single<Void> {
        return feedRepository.uploadImage(image: image)
            .flatMap { [weak self] imageURL in
                guard let self = self else {
                    return Single.error(NSError(domain: "FeedUseCase", code: -1, userInfo: [NSLocalizedDescriptionKey: "Self is nil"]))
                }
                
                let feed = Feed(caption: feed.caption,
                                imageURL: imageURL,
                                timestamp: nil)
                return self.feedRepository.uploadFeed(feed: feed)
            }
    }
}
