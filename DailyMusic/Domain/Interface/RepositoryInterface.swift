//
//  Repositories.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/7/24.
//

import Foundation
import RxSwift

protocol GetFeedRepository {
    func getData() -> Single<[Feed]>
}
