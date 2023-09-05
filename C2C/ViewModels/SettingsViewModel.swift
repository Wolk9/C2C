//
//  SettingsViewModel.swift
//  C2C
//
//  Created by Martin de Bes on 04/09/2023.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
        
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func deleteAccount() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        // First remove DBUser!
        try await UserManager.shared.deleteUser(userId: authUser.uid)
        // Secondly remove AuthUser!
        try await AuthenticationManager.shared.removeAccount()
        // The other way around does not work as the user is not authenticated anymore and you lack permissions to delete the DBUser aftwerwards.
        
        try AuthenticationManager.shared.signOut()
       
    }
}
