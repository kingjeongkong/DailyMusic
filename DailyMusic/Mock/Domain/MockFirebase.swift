//
//  MockFirebase.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/23/24.
//

import Foundation
import UIKit // UIImage를 사용하기 위해 필요
import FirebaseStorage
import FirebaseFirestore

// Mock classes
//class MockFirestore: Firestore {
//    var mockQuerySnapshot: QuerySnapshot?
//    var addDocumentCalled = false
//
//    static func firestore() -> Firestore {
//        return MockFirestore()
//    }
//
//    override func collection(_ collectionPath: String) -> CollectionReference {
//        return MockCollectionReference(firestore: self, path: collectionPath)
//    }
//}
//
//class MockCollectionReference: CollectionReference, @unchecked Sendable {
//    override init(firestore: Firestore, path: String) {
//        super.init(firestore: firestore, path: path, converter: nil)
//    }
//
//    override func addDocument(data: [String : Any], completion: ((Error?) -> Void)? = nil) {
//        (firestore as! MockFirestore).addDocumentCalled = true
//        completion?(nil)
//    }
//
//    override func getDocuments(source: FirestoreSource = .default, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
//        completion((firestore as! MockFirestore).mockQuerySnapshot, nil)
//    }
//}
//
//class MockStorage: Storage {
//    var mockDownloadURL: URL?
//
//    override init() {
//        super.init()
//    }
//
//    static func storage() -> Storage {
//        return MockStorage()
//    }
//
//    override func reference() -> StorageReference {
//        return MockStorageReference(storage: self, path: "")
//    }
//}
//
//class MockStorageReference: StorageReference, @unchecked Sendable {
//    override init(storage: Storage, path: String) {
//        super.init(storage: storage, path: path)
//    }
//
//    override func putData(_ data: Data, metadata: StorageMetadata? = nil, completion: ((StorageMetadata?, Error?) -> Void)? = nil) {
//        completion?(nil, nil)
//    }
//
//    override func downloadURL(completion: @escaping (URL?, Error?) -> Void) {
//        completion((storage as! MockStorage).mockDownloadURL, nil)
//    }
//}
