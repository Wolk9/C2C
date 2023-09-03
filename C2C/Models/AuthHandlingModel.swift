//  AuthHandlingModel.swift
//  C2C
//
//  Created by Martin de Bes on 02/09/2023.
//

import SwiftUI
import FirebaseAuth

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

class AuthHandlingModel: ObservableObject {
    @Published var currentUser: FirebaseAuth.User?
    @EnvironmentObject var global: GlobalHandlingModel
    @EnvironmentObject var errorHandling: ErrorHandlingModel

    
    // Sign in with email and password
    func signIn(withEmail email: String, password: String, errorHandler: ErrorHandlingModel) async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            self.currentUser = Auth.auth().currentUser
        } catch {
            print("DEBUG signIn: failed to login user with error \(error.localizedDescription)")
            errorHandling.handle(error: error)
        }
    }
    
    // Create a new user
    func createUser(withEmail email: String, password: String, errorHandler: ErrorHandlingModel) async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            self.currentUser = Auth.auth().currentUser
        } catch {
            print("DEBUG createUser: failed to create user with error \(error.localizedDescription)")
            errorHandling.handle(error: error)
        }
    }
}
