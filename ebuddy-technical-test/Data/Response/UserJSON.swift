//
//  UserJSON.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 04/12/24.
//

import FirebaseFirestore

struct UserJSON: Codable, Identifiable {
    
    @DocumentID var id: String?
    var email, image, phone: String?
    var gender: GenderEnum?
    var price: Int?
    var rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "uid"
        case phone = "tel"
        case gender = "ge"
        case email
        case image = "img"
        case price = "p"
        case rating = "r"
    }
}

enum GenderEnum: Int, Codable {
    case male = 0
    case female = 1
}

extension UserJSON {
    func copyWith(
        email: String? = nil,
        phone: String? = nil,
        gender: Int? = nil,
        image: String? = nil
    ) -> UserJSON {
        return UserJSON(
            id: self.id,
            email: email ?? self.email,
            image: image ?? self.image,
            phone: phone ?? self.phone,
            gender: GenderEnum(rawValue: gender ?? 0) ?? self.gender
        )
    }
    
    func toUpdateData() -> [AnyHashable: Any] {
        return [
            FirebaseConstant.Field.email: self.email ?? "",
            FirebaseConstant.Field.gender: self.gender?.rawValue ?? 0,
            FirebaseConstant.Field.phone: self.phone ?? "",
            FirebaseConstant.Field.image: self.image ?? "",
        ]
    }
}
