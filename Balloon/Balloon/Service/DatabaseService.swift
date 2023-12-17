//
//  DatabaseService.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 08.12.2023.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    static let shared = DatabaseService()
    
    private init(){}
    
    private let database = Firestore.firestore()
    
    private var userPath: CollectionReference {
        return database.collection("users")
    }
    
    func addUser(user:UserGeneralInfo, completion: @escaping (Error?) -> Void) {
        do {
            try userPath.addDocument(from: user)
        } catch {
            completion(error)
        }
        completion(nil)
    }
}
