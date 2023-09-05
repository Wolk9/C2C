//
//  SettingsView.swift
//  C2C
//
//  Created by Martin de Bes on 04/09/2023.
//

import SwiftUI


struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        List {
            Button("log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                        
                    } catch {
                        print(error)
                    }
                }
                
            }
            Button("Reset Password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password Reset!")
                        
                    } catch {
                        print(error)
                    }
                }
                
            }
            Button("Delete account", role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        print("Account Deleted!!")
                        
                    } catch {
                        print(error)
                    }
                }
                
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(showSignInView: .constant(false))
        }
    }
}
