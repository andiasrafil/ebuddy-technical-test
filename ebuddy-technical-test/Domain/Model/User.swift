//
//  User.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//

struct User {
    let phone: String
    let gender: Gender
    let email: String
    let id: String
    
    enum Gender: Int {
        case male
        case female
    }
}
