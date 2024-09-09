//
//  FeedResponse.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/7/24.
//

import Foundation
import FirebaseFirestore

struct GetFeedResponseDTO {
    let caption: String?
    let imageURL: String?
    let timestamp: Timestamp
    
    init(document: [String: Any]) {
        self.caption = document["caption"] as? String
        self.imageURL = document["imageURL"] as? String
        self.timestamp = document["timestamp"] as? Timestamp ?? Timestamp()
    }
}

extension GetFeedResponseDTO {
    func toDomainFeed() -> Feed {
        return Feed(caption: self.caption,
                    imageURL: self.imageURL,
                    timestamp: self.timestamp.dateValue())
    }
}
