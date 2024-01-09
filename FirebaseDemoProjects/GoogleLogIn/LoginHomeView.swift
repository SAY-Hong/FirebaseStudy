//
//  LoginHomeView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/09.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct LoginHomeView: View {
    @ObservedObject var googleManager = GoogleLoginManager.shared
    @State var email = ""
    @State var password = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text("Login")
                .font(.largeTitle)
                .bold()
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
        }
        .padding()
        
        Divider()
        
        Button(action: { Task {
            await googleManager.signInWithGoogle()
        } }, label: {
            Text("Sign in with Google")
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(alignment: .leading) {
                    Image("Apple")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, alignment: .center)
                }
        })
        .padding()
        .buttonStyle(.bordered)
        
        Text("")
    }
}

#Preview {
    LoginHomeView()
}

