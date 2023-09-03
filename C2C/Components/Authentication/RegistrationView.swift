//
//  RegistrationView.swift
//  Clock2Clock
//
//  Created by Macbook  on 27/08/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var error: ErrorHandlingModel
    @EnvironmentObject var auth: AuthHandlingModel
    
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !firstName.isEmpty
        && !lastName.isEmpty
        && confirmPassword == password
    }
    
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
                    InputView(text: $firstName,
                              title: "First Name",
                              placeHolder: "Enter your First Name")
                    InputView(text: $lastName,
                              title: "Last Name",
                              placeHolder: "Enter your Last Name")
                    InputView(text: $password,
                              title: "Password",
                              placeHolder: "Enter your password",
                              isSecureField: true)
                    ZStack(alignment: .trailing) {
                        InputView(text: $confirmPassword,
                                  title: "Confirm Password",
                                  placeHolder: "Enter your password again",
                                  isSecureField: true)
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                                
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button {
                    Task {
                        await auth.createUser(withEmail: email, password: password)
//                       await auth.createUser(withEmail: email,
//                                                   password: password,
//                                                   firstName: firstName,
//                                                   lastName: lastName,
//                                                   fullName: "\(firstName) \(lastName)",
//                                                   dob: Date(),
//                                                   contractDate: Date(),
//                                                   hoursPerWeek: 0,
//                                                   role: "user",
//                                                   errorHandler: error
//                        )
                    }
                } label: {
                    HStack {
                        Text("Sign Up")
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
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Sign In")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                
            }
        }
    }
}

//MARK - AuthenticationFormProtocol

//extension RegistrationView: AuthenticationFormProtocol {
//    var formIsValid: Bool {
//        return !email.isEmpty
//        && email.contains("@")
//        && !password.isEmpty
//        && password.count > 5
//        && !firstName.isEmpty
//        && !lastName.isEmpty
//        && confirmPassword == password
//    }
//}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(GlobalHandlingModel())
            .environmentObject(AuthHandlingModel())
            .environmentObject(ErrorHandlingModel())
    }
}
