//
//  FeedResponse.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/7/24.
//

import Foundation
import FirebaseFirestore

struct FeedResponseDTO {
    let caption: String?
    let imageURL: String?
    let timestamp: Timestamp
}
