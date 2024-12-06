//
//  UserRepository.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//

import UIKit

protocol UserRepository {
    func getAllUsers() async -> [UserJSON]
    func anonymousSignIn() async -> Bool
    func uploadImage(image: UIImage, uid: String) async -> String?
    func updateUserData(forId uid: String, value: [AnyHashable: Any]) async
}
