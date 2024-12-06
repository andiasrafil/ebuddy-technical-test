//
//  ebuddy_technical_testApp.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 04/12/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ebuddy_technical_testApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var dashboardVM: DashboardView.DashboardViewModel = .init()
    @StateObject var appState: AppState = .init()
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(self.dashboardVM)
                .environmentObject(self.appState)
        }
    }
}
