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
    @State var isEmailError = true
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                TextField("이름을 입력하세요: ", text: $nameText)
                    .padding()
                    .background(.thinMaterial)
                    .onChange(of: nameText) {
                        isNameCountError = nameText.count < 2 ? true : false
                    }
                Text("이름은 2자 이상 입력해주세요.")
                    .foregroundStyle(isNameCountError ? .red : .clear)
            }
            TextField("이메일을 입력하세요: ", text: $emailText)
                .padding()
                .background(.thinMaterial)
                .onChange(of: emailText) {
                    isEmailError = !isVaildEmail(emailText) ? true : false
                    print(isEmailError)
                }
            SecureField("비밀번호 6자리 이상 입력하세요: ", text: $passwordText)
                .padding()
                .background(.thinMaterial)
            SecureField("비밀번호 다시 입력하세요: ", text: $passwordTConfirmText)
                .padding()
                .background(.thinMaterial)
            
            Button("가입") {
                authManager.emailAuthSignUp(userName: nameText, email: emailText, password: passwordText)
            }
        }
        .padding()
        
    }
}

// 이메일 형식 검사
func isVaildEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailConfirm = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailConfirm.evaluate(with: email)
}
#Preview {
    AuthAddView()
}
