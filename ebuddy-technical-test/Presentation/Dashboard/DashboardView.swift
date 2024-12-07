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
                Button(action: {
                    self.appState.changeColorScheme()
                }, label: {
                    Text("Change Theme")
                })
                Button(action: {
                    Task {
                        await self.viewModel.sortUser()
                    }
                }, label: {
                    Text("sort")
                })
                ScrollView(showsIndicators: false) {
                    ForEach(self.$viewModel.user) { $data in
                        NavigationLink {
                            UserDetailView(user: $data, viewModel: viewModel)
                        } label: {
                            UserCardView(user: data, onSuccessSelectImage: { image in
                                let result = await self.viewModel.uploadPhoto(forUser: data.id ?? "", image: image)
                                return result
                            })
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}
