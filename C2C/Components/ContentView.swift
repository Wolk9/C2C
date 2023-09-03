//
//  ContentView.swift
//  C2C
//
//  Created by Martin de Bes on 02/09/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var auth = AuthHandlingModel()
    @StateObject var error = ErrorHandlingModel()
    @StateObject var global = GlobalHandlingModel()
    
    var body: some View {
        VStack {
            if auth.currentUser != nil {
                // MainView()
                TabView {
                    CicoView()
                        .badge(global.eventIsRunning)
                        .tabItem{
                            Image(systemName: "clock.fill")
                            Text("CiCo")
                        }
                    EventsListView()
                        .tabItem {
                            Image(systemName: "list.number")
                            Text("Events")
                        }
                    AccountView()
                        .tabItem{
                            Image(systemName: "person.2.fill")
                            Text("Account")
                        }
                }
                .padding(.top, 3)
            } else {
                AuthView()
            }
        }
        .environmentObject(auth)
        .environmentObject(error)
        .environmentObject(global)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthHandlingModel())
            .environmentObject(ErrorHandlingModel())
            .environmentObject(GlobalHandlingModel())
    }
}
