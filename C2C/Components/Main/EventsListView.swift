//
//  EventsListView.swift
//  C2C
//
//  Created by Martin de Bes on 03/09/2023.
//

import SwiftUI

struct EventsListView: View {
    var body: some View {
        ZStack {
            Color.green
            Image(systemName: "list.number")
                .foregroundColor(Color.white)
                .font(.system(size: 100.0))
        }
    }
}

struct EventsListView_Previews: PreviewProvider {
    static var previews: some View {
        EventsListView()
    }
}
