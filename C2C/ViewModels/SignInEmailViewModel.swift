//
//  SignInEmailViewModel.swift
//  C2C
//
//  Created by Martin de Bes on 05/09/2023.
//

import Foundation

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        let AuthDataResult = try await AuthenticationManager.shared.createUser(
            email: email,
            password: password)
        let user = DBUser(auth: AuthDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(
            email: email,
            password: password)
    }
}
