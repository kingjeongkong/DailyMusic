//
//  Repositories.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/7/24.
//

import UIKit
import RxSwift

protocol FeedRepository {
    func getFeed() -> Single<[Feed]>
    func uploadImage(image: UIImage) -> Single<String>
    func uploadFeed(feed: Feed) -> Completable
}
