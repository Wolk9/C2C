//
//  RootView.swift
//  C2C
//
//  Created by Martin de Bes on 04/09/2023.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        
        ZStack {
            NavigationStack {
                ProfileView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            print("authUser \(String(describing: authUser))")
            self.showSignInView = authUser != nil
            print("showSignInView", self.showSignInView)
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
        
        

    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
