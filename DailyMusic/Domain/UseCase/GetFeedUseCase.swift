//
//  GetFeedUseCase.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/9/24.
//

import Foundation
import RxSwift

final class GetFeedUseCase {
    private let getFeedRepository: GetFeedRepository
    
    init(getFeedRepository: GetFeedRepository) {
        self.getFeedRepository = getFeedRepository
    }
    
    func getFeed() -> Single<[Feed]> {
        return getFeedRepository.getData()
    }
}
