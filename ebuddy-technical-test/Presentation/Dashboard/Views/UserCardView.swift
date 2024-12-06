//
//  UserCardView.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//

import SwiftUI

struct UserCardView: View {
    var user: UserJSON
    var onSuccessSelectImage: (Image) async -> Bool
    var body: some View {
        HStack {
            VStack {
                Text("id: \(user.id ?? "")")
                Text("email: \(user.email ?? "")")
                Text("gender: \(user.gender ?? .male)")
                Text("phone: \(user.phone ?? "")")
            }
            if let imageUrl = user.image, !imageUrl.isEmpty {
                AsyncImage(url: URL(string: imageUrl)!) {
                    $0.image?.resizable()
                }
                    .scaledToFill()
                    
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            } else {
                ImageProfileView(viewModel: .init(onSuccess: { image in
                    return await self.onSuccessSelectImage(image)
                }))
            }
        }
    }
}
