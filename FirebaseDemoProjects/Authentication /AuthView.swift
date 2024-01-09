//
//  AuthView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/09.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @ObservedObject var authManager = AuthManager.shared
    @State var email = ""
    @State var password = ""
    var body: some View {
        NavigationStack {
            VStack {
                if authManager.state == .signedOut {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                    Button("Sign in") {
                        // MARK: Auth.auth()
                        authManager.emailAuthSignIn(email: email, password: password)
                    }
                } else {
                    Button("Sign out") {
                        authManager.signOut()
                    }
                    
                    Button("Account Delete") {
                        if let user = Auth.auth().currentUser {
                            user.delete { error in
                                if let error = error {
                                    print("Error deleting user", error)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                // 로그인한 상태
                authManager.checkSignInOut()
            }
        }
    }
}

#Preview {
    AuthView()
}
