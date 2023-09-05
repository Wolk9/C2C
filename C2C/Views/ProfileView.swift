//
//  ProfileView.swift
//  C2C
//
//  Created by Martin de Bes on 04/09/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        
        List {
            if let user = viewModel.user {
                Text("UserId: \(user.userId)")
                Button {
                    viewModel.toggleAdminStatus()
                } label: {
                    Text("User is Admin: \(user.role == "user" ? "no":"yes")")
                }
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView(showSignInView: .constant(false))
        }
    }
}
