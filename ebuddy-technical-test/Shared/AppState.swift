//
//  AppState.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 06/12/24.
//
import Foundation
import SwiftUI
@MainActor
class AppState: ObservableObject {
    @Published var currentSelectedUser: UserJSON?
    @Published var colorScheme: ColorScheme = .light
    
    
    func changeColorScheme() {
        if colorScheme == .dark {
            colorScheme = .light
        } else {
            colorScheme = .dark
        }
    }
}
