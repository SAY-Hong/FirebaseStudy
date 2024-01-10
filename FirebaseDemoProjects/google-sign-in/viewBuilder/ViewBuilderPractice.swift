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

// MARK: ViewBuilder
// 뷰를 사용하는 누군가가 자신의 컨텐츠를 전달할 수 있도록 하기 위해 매개변수 제공 -> @ViewBuilder 수정자를 사용하여 클로저 전달.
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

// afterViewBuilder를 자동으로 채우는 생성자를 작성하기
// where절의 확장을 사용한다. -> 특정 일반 제약 조건에 대한 확장
// Preview에서 뷰 안에 내용이 옵셔널일 경우에 화면에 어떻게 나타낼지를 미리 정하는 것.
extension afterViewBuilder where Content == Color {
    init() {
        self.init {
            Color.black
        }
    }
}
#Preview {
    afterViewBuilder()
        .padding()
}
