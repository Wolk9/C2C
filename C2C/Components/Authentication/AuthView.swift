//
//  AuthView.swift
//  C2C
//
//  Created by Martin de Bes on 02/09/2023.
//

import SwiftUI

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
    
    @EnvironmentObject var error: ErrorHandlingModel
    @EnvironmentObject var auth: AuthHandlingModel
    @EnvironmentObject var global: GlobalHandlingModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image("CICO_Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 100)
                    .padding(.vertical, 32)
                
                // form fields
                
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeHolder: "name@example.com")
                        .autocapitalization(.none)
                    InputView(text: $password,
                              title: "Password",
                              placeHolder: "Enter your password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Sign In button
                
                Button {
                    Task {
                        await auth.signIn(withEmail: email, password: password, errorHandler: error)
                    }
                } label: {
                    HStack {
                        Text("Sign In")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    
                    
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                // Sing Up button
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(GlobalHandlingModel())
            .environmentObject(AuthHandlingModel())
            .environmentObject(ErrorHandlingModel())
    }
}
