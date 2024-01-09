//
//  Welcomeview.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/09.
//

import SwiftUI

struct Welcomeview: View {
    @State var name: String = ""
    var body: some View {
        Text("Hello, World!")
        Text(name)
        
    }
}

#Preview {
    Welcomeview()
}
