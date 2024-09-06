//
//  AddFeedViewModel.swift
//  DailyMusic
//
//  Created by 왕정빈 on 2024/04/16.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore

final class AddFeedViewModel {
    
    private let storage = Storage.storage()
    
    func uploadFeed(image: UIImage?, caption: String?, completion: @escaping () -> Void) {
        guard let image = image else { return }
        guard let caption = caption else { return }
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let storageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            
            storageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("fail to download URL")
                    return
                }
                
                let db = Firestore.firestore()
                db.collection("feeds").addDocument(data: [
                    "caption": caption,
                    "imageURL": downloadURL.absoluteString,
                    "timestamp": FieldValue.serverTimestamp()
                ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        completion()
                    }
                }
            }
        }
    }
}
