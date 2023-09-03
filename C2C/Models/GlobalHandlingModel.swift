//
//  GlobalHandlingModel.swift
//  C2C
//
//  Created by Martin de Bes on 03/09/2023.
//

import SwiftUI

class GlobalHandlingModel: ObservableObject {
    @Published var selectedTab =  "Home"
    @Published var eventIsRunning = 0

}



//struct GlobalHandlingModel_Previews: PreviewProvider {
//    static var previews: some View {
//        GlobalHandlingModel()
//    }
//}
