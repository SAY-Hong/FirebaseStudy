//
//  ViewBuilderPractice.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/11.
//

import SwiftUI

struct beforeViewBuilder: View {
    var body: some View {
        Text("Hello, World!")
            .padding(100)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 50, height: 10)))
            .shadow(color: .gray, radius: 10, x: 5, y: 5)
    }
}

struct afterViewBuilder <Content : View> : View {
    let content: Content
    init(@ViewBuilder contentBuilder: () -> Content) {
        self.content = contentBuilder()
    }
    var body: some View {
        content
            .padding(100)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 50, height: 10)))
            .shadow(color: .gray, radius: 10, x: 5, y: 5)
    }
}

#Preview {
    afterViewBuilder {
        Text("Hello!")
    }
}
