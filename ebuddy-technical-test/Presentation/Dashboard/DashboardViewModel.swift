//
//  DashboardViewModel.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//
import Foundation

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
    }
}

