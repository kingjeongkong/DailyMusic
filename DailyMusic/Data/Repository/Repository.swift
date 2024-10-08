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

final class FeedFirebaseRepository: FeedRepository {
    
    private let db: Firestore
    private let storage: Storage
    
    // 의존성 주입을 위한 생성자 추가
    init(db: Firestore = Firestore.firestore(), storage: Storage = Storage.storage()) {
        self.db = db
        self.storage = storage
    }
    
    func getFeed() -> Single<[Feed]> {
        return Single.create { single in
            self.db.collection("feeds")
                .order(by: "timestamp", descending: true)
                .getDocuments(source: .server) { querySnapshot, error in
                    if let error = error {
                        single(.failure(error))
                    }
                    
                    var feeds: [Feed] = []
                    
                    querySnapshot?.documents.forEach({ document in
                        let data = document.data()
                        let feedDTO  = GetFeedResponseDTO(document: data)
                        let feed = feedDTO.toDomainFeed()
                        feeds.append(feed)
                    })
                    single(.success(feeds))
                }
            return Disposables.create()
        }
    }
    
    func uploadImage(image: UIImage) -> Single<String> {
        return Single.create { [weak self] single in
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                single(.failure(NSError(domain: "Invalid Image Data", code: -1)))
                return Disposables.create()
            }
            
            let storageRef = self?.storage.reference().child("images/\(UUID().uuidString).jpg")
            storageRef?.putData(imageData, metadata: nil) { _, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                storageRef?.downloadURL { url, error in
                    if let error = error {
                        single(.failure(error))
                        return
                    }
                    guard let downloadURL = url else {
                        single(.failure(NSError(domain: "URL Error", code: -1)))
                        return
                    }
                    single(.success(downloadURL.absoluteString))
                }
            }
            return Disposables.create()
        }
    }
    
    func uploadFeed(feed: Feed) -> Single<Void> {
        return Single.create { [weak self] single in
            let feedData: [String: Any] = [
                "caption": feed.caption ?? "",
                "imageURL": feed.imageURL ?? "",
                "timestamp": FieldValue.serverTimestamp()
            ]
            
            self?.db.collection("feeds").addDocument(data: feedData, completion: { error in
                if let error = error {
                    single(.failure(error))
                } else {
                    single(.success(()))
                }
            })
            return Disposables.create()
        }
    }
    
}
