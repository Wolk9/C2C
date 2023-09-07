//
//  PofileViewModel.swift
//  C2C
//
//  Created by Martin de Bes on 04/09/2023.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func toggleAdminStatus() {
        guard var user else { return }
        let newRole = user.role == "user" ?  "admin" : "user"
        Task {
            try await UserManager.shared.updateAdminUserStatus(userId: user.userId, role: newRole )
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
        
    }
}
