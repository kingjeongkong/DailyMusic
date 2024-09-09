//
//  Repository.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/7/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import RxSwift

final class GetFeedFirebaseRepository: GetFeedRepository {
    
    let db = Firestore.firestore()
    
    func getData() -> Single<[Feed]> {
        return Single.create { single in
            self.db.collection("feeds")
                .order(by: "timestamp", descending: true)
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        single(.failure(error))
                    }
                    
                    var feeds: [Feed] = []
                    
                    querySnapshot?.documents.forEach({ document in
                        let data = document.data()
                        let feedDTO  = FeedResponseDTO(document: data)
                        let feed = feedDTO.toDomainFeed()
                        feeds.append(feed)
                        
                    })
                    single(.success(feeds))
                }
            return Disposables.create()
        }
    }
}
