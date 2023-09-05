//
//  UserManager.swift
//  C2C
//
//  Created by Martin de Bes on 05/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser: Codable {
    let userId: String
    let email: String
    let photoUrl: String?
    let role: String
    let firstName: String?
    let lastName: String?
    let dob: String?
    let contractDate: String?
    let hoursPerWeek: Int?
   
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email ?? ""
        self.photoUrl = auth.photoUrl
        self.role = "user"
        self.firstName = ""
        self.lastName = ""
        self.dob = ""
        self.contractDate = ""
        self.hoursPerWeek = 0
    }
    
    init(
        userId: String,
        email: String,
        photoUrl: String? = nil,
        role: String,
        firstName: String? = nil,
        lastName: String? = nil,
        dob: String? = nil,
        contractDate: String? = nil,
        hoursPerWeek: Int? = nil
        ) {
            self.userId = userId
            self.email = email
            self.photoUrl = photoUrl
            self.role = role
            self.firstName = firstName
            self.lastName = lastName
            self.dob = dob
            self.contractDate = contractDate
            self.hoursPerWeek = hoursPerWeek
    }
    
    func toggleAdminStatus() -> DBUser {
        let newRole = role == "user" ?  "admin" : "user"
        return DBUser(
            userId: userId,
            email: email,
            photoUrl: photoUrl,
            role: newRole,
            firstName: firstName,
            lastName: lastName,
            dob: dob,
            contractDate: contractDate,
            hoursPerWeek: hoursPerWeek
        )
    }
}

final class UserManager {
    
    static let shared = UserManager()
    
    private init() {
        
    }
   
    private let userCollection = Firestore.firestore().collection("C2CUsers")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private var encoder: Firestore.Encoder {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    private var decoder: Firestore.Decoder {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }

    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    func deleteUser(userId: String) async throws {
        try await Firestore.firestore().collection("C2CUsers").document(userId).delete()
    }
    
    func updateAdminUserStatus(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: true)
    }
}

