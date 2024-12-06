//
//  DashboardView.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//
import SwiftUI
import FirebaseStorage
import _PhotosUI_SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel = .init()
    var body: some View {
        VStack {
            ForEach(self.viewModel.user, content: { data in
                UserCardView(user: data, onSuccessSelectImage: { image in
                    let result = await self.viewModel.uploadPhoto(forUser: data.id ?? "", image: image)
                    return result
                })
            })
        }
    }
}
