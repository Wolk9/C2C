//
//  ContentView.swift
//  C2C
//
//  Created by Martin de Bes on 04/09/2023.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            VStack() {
                Text("hi")
                Spacer()
            }
        }
        .navigationTitle("ContentView")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(showSignInView: .constant(false))
        }
    }
    
}


