//
//  ErrorHandlingModel.swift
//  Clock2Clock
//
//  Created by Macbook  on 28/08/2023.
//

import Foundation
import SwiftUI

@MainActor
class ErrorHandlingModel: ObservableObject {
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    // Call this function when an error occurs
    func handle(error: Error) {
        self.showError = true
        print("ERROR: ErrorHandlingModal \(error.localizedDescription), \(showError)")
        self.errorMessage = error.localizedDescription
    }
    
    // Reset the error state
    func resetError() {
        self.errorMessage = ""
        self.showError = false
        print("RESET Error \(showError)")
    }
}
 
