//
//  AppState.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 06/12/24.
//
import Foundation
@MainActor
class AppState: ObservableObject {
    @Published var currentSelectedUser: UserJSON?
}
