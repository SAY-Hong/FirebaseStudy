//
//  AuthManager.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/09.
//

import Foundation
import FirebaseAuth
enum SignInState {
    case signedOut, signedIn
}
class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    private init() {}
    
    @Published var state: SignInState = .signedOut
    
    func emailAuthSignIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error!)
                return
            }
            if let user = result?.user {
                self.state = .signedIn
                print("user email: \(String(describing: user.email))")
                print("user name: \(String(describing: user.displayName))")
            }
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.state = .signedOut
    }
    
    func checkSignInOut() {
        if Auth.auth().currentUser != nil {
            self.state = .signedIn
        }
    }
    
    
}
