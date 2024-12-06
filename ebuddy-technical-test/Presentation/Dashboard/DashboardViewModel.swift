//
//  DashboardViewModel.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//
import Foundation
import SwiftUI

extension DashboardView {
    class DashboardViewModel: ObservableObject {
        @Published var user: [UserJSON] = []
        var repository: UserRepository
        
        init(repository: UserRepository = UserRepositoryImpl()) {
            self.repository = repository
            Task {
                await self.getUsers()
            }
        }
        
        func getUsers() async {
            DispatchQueue.main.async {
                Task {
                    self.user = await self.repository.getAllUsers()
                }
            }
        }
        
        func uploadPhoto(forUser id: String, image: Image) async -> Bool {
            let renderer = await ImageRenderer(content: image)
            Task {
                if let image = await renderer.uiImage {
                    let imageUrl = await self.repository.uploadImage(image: image, uid: id)
                    let user = self.user.first(where: { $0.id == id })
                    if let user = user {
                        await self.updateUserData(user: user.copyWith(image: imageUrl))
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
            return false
        }
        func updateUserData(user: UserJSON) async {
            Task {
                await self.repository.updateUserData(forId: user.id ?? "", value: user.toUpdateData())
                let index = self.user.firstIndex(where: { $0.id == user.id })
                if let index = index {
                    DispatchQueue.main.async {
                        self.user.remove(at: index)
                        self.user.insert(user, at: index)
                    }
                }
                
            }
        }
    }
}

