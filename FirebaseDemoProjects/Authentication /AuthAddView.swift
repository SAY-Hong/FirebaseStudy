//
//  AuthAddView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/09.
//

import SwiftUI

struct AuthAddView: View {
    @ObservedObject var authManager = AuthManager.shared
    @State var nameText = ""
    @State var emailText = ""
    @State var passwordText = ""
    @State var passwordTConfirmText = ""
    @State var isNameCountError = true
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("이름을 입력하세요: ", text: $nameText)
                .onChange(of: nameText) {
                    isNameCountError = nameText.count < 2 ? true : false
                }
            Text("이름은 2자 이상 입력해주세요.")
                .foregroundStyle(isNameCountError ? .red : .clear)
            TextField("이메일을 입력하세요: ", text: $emailText)
            SecureField("비밀번호 6자리 이상 입력하세요: ", text: $passwordText)
            SecureField("비밀번호 다시 입력하세요: ", text: $passwordTConfirmText)
            
            Button("가입") {
                authManager.emailAuthSignUp(userName: nameText, email: emailText, password: passwordText)
            }
        }
        .padding()
        .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    AuthAddView()
}
