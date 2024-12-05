//
//  UserJSON.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 04/12/24.
//

import FirebaseFirestore

struct UserJSON: Codable, Identifiable {
    
    @DocumentID var id: String?
    var email, phone: String?
    var gender: GenderEnum?
    
    enum CodingKeys: String, CodingKey {
        case id = "uid"
        case phone = "tel"
        case gender = "ge"
        case email
    }
}

enum GenderEnum: Int, Codable {
    case male = 0
    case female = 1
}
