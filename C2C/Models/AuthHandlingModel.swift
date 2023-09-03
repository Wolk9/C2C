//  AuthHandlingModel.swift
//  C2C
//
//  Created by Martin de Bes on 02/09/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

class AuthHandlingModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @EnvironmentObject var global: GlobalHandlingModel
    @EnvironmentObject var errorHandling: ErrorHandlingModel
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            // await fetchUser()
        }
    }

    
    // Sign in with email and password
    func signIn(withEmail email: String, password: String, errorHandler: ErrorHandlingModel) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            // await fetchUser()
        } catch {
            print("DEBUG signIn: failed to login user with error \(error.localizedDescription)")
            errorHandling.handle(error: error)
        }
    }
    
    func createAccount(email: String, password: String, firstName: String, lastName: String, dob: Date, contractDate: Date, hoursPerWeek: Int, role: String, errorHandler: ErrorHandlingModel) async {
        await createUser(withEmail: email, password: password, errorHandler: errorHandler)
        await createProfile(firstName: firstName, LastName: lastName, dob: dob, contractDate: contractDate, hoursPerWeek: hoursPerWeek, role: role, errorHandler: errorHandler)
    }
    
    // Create a new user
    func createUser(withEmail email: String, password: String, errorHandler: ErrorHandlingModel) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG createUser: failed to create user with error \(error.localizedDescription)")
            errorHandling.handle(error: error)
        }
    }
    
    func createProfile(firstName: String, lastName: String, dob: Date, contractDate: Date, hoursPerWeek: Int, role: String, errorHandler: ErrorHandlingModel) async {
        
        let user = User(id: userSession.user.uid,
                        firstName: firstName,
                        lastName: lastName,
                        contractDate: contractDate,
                        dob: dob,
                        hoursPerWeek: 0,
                        role: role
        )
        let encodedUser = try Firestore.Encoder().encode(user)
        try await Firestore.firestore().collection("C2CUsers").document(user.id).setData(encodedUser)
        
        // C2CUsers is tijdelijk. users moet het worden

        
 
        
    }
}
