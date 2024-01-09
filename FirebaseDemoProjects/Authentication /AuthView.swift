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
            }
            .padding()
        }
    }
}

#Preview {
    AuthView()
}
