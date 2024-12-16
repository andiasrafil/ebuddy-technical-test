//
//  UserDetailView.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 06/12/24.
//
import SwiftUI
struct UserDetailView: View {
    @Binding var user: UserJSON
    @ObservedObject var viewModel: DashboardView.DashboardViewModel
    @EnvironmentObject var appState: AppState
    var body: some View {
        VStack {
            Text("current selected User: \(appState.currentSelectedUser?.email ?? "") andi asrafil")
            if let imageUrl = user.image, !imageUrl.isEmpty {
                AsyncImage(url: URL(string: imageUrl)!) {
                    $0.image?.resizable()
                }
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
            } else {
                ImageProfileView(viewModel: .init(onSuccess: { image in
                    let result = await self.viewModel.uploadPhoto(forUser: user.id ?? "", image: image)
                    return result
                }))
            }
            TextField(text: $user.email.toUnwrapped(defaultValue: ""), label: {
                Text(user.email ?? "")
            })
            TextField(text: $user.phone.toUnwrapped(defaultValue: ""), label: {
                Text(user.email ?? "")
            })
        }
        .onAppear {
            self.appState.currentSelectedUser = user
        }
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
