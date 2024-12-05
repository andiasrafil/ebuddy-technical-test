//
//  UserRepository.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//

protocol UserRepository {
    func getAllUsers() async -> [UserJSON]
}
