//
//  DashboardView.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//
import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel = .init()
    var body: some View {
        VStack {
            ForEach(self.viewModel.user, content: { data in
                VStack {
                    Text("id: \(data.id ?? "")")
                    Text("email: \(data.email ?? "")")
                    Text("gender: \(data.gender ?? .male)")
                    Text("phone: \(data.phone ?? "")")
                }
            })
        }
    }
}
