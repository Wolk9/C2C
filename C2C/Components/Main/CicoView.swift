//
//  CicoView.swift
//  C2C
//
//  Created by Martin de Bes on 03/09/2023.
//

import SwiftUI

struct CicoView: View {
    var body: some View {
        ZStack {
            Color.blue
            Image(systemName: "clock")
                .foregroundColor(Color.white)
                .font(.system(size: 100.0))
        }
    }
}

struct CicoView_Previews: PreviewProvider {
    static var previews: some View {
        CicoView()
    }
}
