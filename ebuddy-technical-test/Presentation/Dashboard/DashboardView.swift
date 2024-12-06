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
    @EnvironmentObject var viewModel: DashboardViewModel
    @EnvironmentObject var appState: AppState
    var body: some View {
        NavigationView {
            VStack {
                Text("current selected User: \(appState.currentSelectedUser?.email ?? "")")
                List(self.$viewModel.user, rowContent: { $data in
                    NavigationLink {
                        UserDetailView(user: $data, viewModel: viewModel)
                    } label: {
                        UserCardView(user: data, onSuccessSelectImage: { image in
                            let result = await self.viewModel.uploadPhoto(forUser: data.id ?? "", image: image)
                            return result
                        })
                    }
                })
            }
        }
    }
}
