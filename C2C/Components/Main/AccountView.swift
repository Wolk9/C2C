//
//  AccountView.swift
//  C2C
//
//  Created by Martin de Bes on 03/09/2023.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ZStack {
            Color.red
            Image(systemName: "person.crop.circle")
                .foregroundColor(Color.white)
                .font(.system(size: 100.0))
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
