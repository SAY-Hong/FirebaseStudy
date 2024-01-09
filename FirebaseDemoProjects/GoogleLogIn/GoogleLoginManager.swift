//
//  GoogleLoginManager.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/09.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class GoogleLoginManager: ObservableObject {
    static let shared = GoogleLoginManager()
    
    private init() {}
    
    enum AuthenticationError: Error {
        case tokenError(message: String)
    }

    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration.")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else {
            print("There is no root!")
            return false
        }
        
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else {
                throw AuthenticationError.tokenError(message: "ID token missing")
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    //    return false
    }
    func signOutWithGoogle() {
        
    }
}




