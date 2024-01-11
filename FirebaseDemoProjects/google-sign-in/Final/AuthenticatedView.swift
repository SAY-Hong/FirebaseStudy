//
//  AuthView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/10.
//

import SwiftUI

// Unauthenticated가 EmptyView일 경우를 고려 -> 이니셜라이저 추가.
// extension으로 인해 Unauthenticated에 띠로 뷰를 지정하지 않고도 사용할 수 있음
extension AuthenticatedView where Unauthenticated == EmptyView {
    init(@ViewBuilder content: @escaping () -> Content) {
        self.unauthenticated = nil
        self.content = content
    }
}

// 두 개의 제네릭 변수 Content, Unauthenticated를 받는다.
// Content -> 사용자가 인증되었을 때 표시되는 내용
// Unauthenticated -> 사용자가 인증되지 않았을 때 표시되는 내용
struct AuthenticatedView<Content, Unauthenticated>: View where Content: View, Unauthenticated: View {
    // 사용자의 인증 상태를 관리하기 위한 상태 속성 정의하기.
    @StateObject private var viewModel = AuthenticationViewModel()

    var unauthenticated: Unauthenticated? // 사용자가 인증되지 않았을 때 표시되는 뷰
    
    // ViewBuilder -> 여러 뷰를 결합하여 하나의 뷰로 만들기 위해 사용되는 기능
    @ViewBuilder var content: () -> Content // 사용자가 인증되었을 때 표시되는 뷰를 나타내는 클로저
    
    // 이니셜라이저는 사용자가 인증되지 않았을 대 표시되는 뷰와 사용자가 인증되었을 때 표시되는 뷰를 받아 초기화 한다.
    // unauthenticated: 사용자가 인증되지 않았을 때 표시될 뷰를 나타낸디.
    // 타입-> Unauthenticated, 사용자가 인증되지 않았을 때의 뷰가 제공되거나 nil
    // content: 사용자가 인증되었을 때 표시될 뷰를 정의하는 ViewBuilder 클로저
    public init(unauthenticated: Unauthenticated?, @ViewBuilder content: @escaping () -> Content) {
        self.unauthenticated = unauthenticated
        self.content = content
    }
    // unauthenticated: 사용자가 인증되지 않았을 때 표시될 뷰를 정의하는 ViewBuilder 클로저
    // -> Unauthenticated 타입의 뷰를 생성하며, 사용자가 인증되지 않았을 때 표시될 내용을 정의.
    public init(@ViewBuilder unauthenticated: @escaping () -> Unauthenticated, @ViewBuilder content: @escaping () -> Content) {
        self.unauthenticated = unauthenticated()
        self.content = content
    }
    var body: some View {
        switch viewModel.authenticationState {
        case .unauthenticated, .authenticating:
            VStack {
                if let unauthenticated {
                    unauthenticated
                } else {
                    Text("You're not logged in.")
                }
                Button("Tap here to Login") {
                    viewModel.reset()
                }
            }
        case .authenticated:
            VStack {
                content()
                Text("You're logged in as")
            }
        }
    }
}

#Preview {
    // 얘는 사용자가 인증되었을 때 보여줄 뷰 빌더 내용!
    AuthenticatedView {
        Text("You're signed in. ")
    }
}
