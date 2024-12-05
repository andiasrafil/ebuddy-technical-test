//
//  UserRepositoryImpl.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//

import Foundation
import FirebaseFirestore

class UserRepositoryImpl: ObservableObject, UserRepository {
    let path = "USERS"
    let firestore = Firestore.firestore()
    func getAllUsers() async -> [UserJSON] {
        do {
            let result = try await firestore.collection(path).getDocuments()
            return try result.documents.map({ try $0.data(as: UserJSON.self)})
        } catch {
            return []
        }
    }
    
    
}
