//
//  HomeViewModel.swift
//  DailyMusic
//
//  Created by 왕정빈 on 2024/04/16.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

final class HomeViewModel {
    
    let db = Firestore.firestore()
    
    func getData(_ completionHandler: @escaping ([Feed]) -> Void) {
        db.collection("feeds")
            .order(by: "timestamp", descending: true)
            .getDocuments { (querySnapshot, error) in
                var feeds: [Feed] = []
                
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else { return }
                    
                    for document in documents {
                        let data = document.data()
                        let caption = data["caption"] as? String ?? ""
                        let imageURL = data["imageURL"] as? String ?? ""
                        let timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
                        
                        let feed = Feed(caption: caption, imageURL: imageURL, timestamp: timestamp, uuid: UUID())
                        feeds.append(feed)
                    }
                    completionHandler(feeds)
                }
            }
    }
}
