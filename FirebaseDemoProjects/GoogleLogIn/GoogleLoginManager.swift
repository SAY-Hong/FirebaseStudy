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
        
        // rootViewController
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else {
            print("There is no root!")
            return false
        }
        
        do {
            // 로그인 진행
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else {
                throw AuthenticationError.tokenError(message: "ID token missing")
            }
            
            // Firebase에 구글로 로그인한 계정 추가하기.
            // 밑의 과정은 파베 쪽에서 uid를 보기 위해 쓴 코드인듯.
            // 밑의 코드가 없으면 파베에 저장이 안된다.
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
    }
    
    func signOutWithGoogle() {
        
    }
}
