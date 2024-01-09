//
//  AuthView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/09.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @State var email = ""
    @State var password = ""
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button("Sign in") {
                    // MARK: Auth.auth()
                    Auth.auth().signIn(withEmail: email, password: password) { result, error in
                        guard error == nil else {
                            print(error!)
                            return
                        }
                        if let user = result?.user {
                            print("Success: \(user.uid)")
                        }
                    }
                }
                
                Button("Sign out") {
                    try? Auth.auth().signOut()
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
            .padding()
            .onAppear {
                // 로그인한 상태
                if Auth.auth().currentUser != nil {
                    print("로그인 중")
                } else {
                    print("로그인 필요")
                }
            }
        }
    }
}

#Preview {
    AuthView()
}
