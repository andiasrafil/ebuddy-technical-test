//
//  UserRepositoryImpl.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class UserRepositoryImpl: ObservableObject, UserRepository {
    let path = FirebaseConstant.Collection.users
    let firestore = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    func getAllUsers() async -> [UserJSON] {
        do {
            let result = try await firestore.collection(path).getDocuments()
            return try result.documents.map({ try $0.data(as: UserJSON.self)})
        } catch {
            return []
        }
    }
    
    func anonymousSignIn() async -> Bool {
        do {
            if Auth.auth().currentUser == nil {
                try await Auth.auth().signInAnonymously()
            }
            return true
        } catch {
            return false
        }
    }
    
    func uploadImage(image: UIImage, uid: String) async -> String? {
        let imageData = image.jpegData(compressionQuality: 0.8)
        guard let imageData = imageData else {
            return nil
        }
        let path = "images/\(uid).jpg"
        let fileRef = self.storageRef.child(path)
        do {
            let result = try await fileRef.putDataAsync(imageData)
            let downloadUrl = try await fileRef.downloadURL()
            return downloadUrl.absoluteString
        } catch {
            print("\(error)")
            return nil
        }
    }
    
    func updateUserData(forId uid: String, value: [AnyHashable: Any]) async {
        do {
            try await self.firestore.collection(path).document(uid).updateData(value)
        } catch {
            print("\(error)")
        }
    }
}
