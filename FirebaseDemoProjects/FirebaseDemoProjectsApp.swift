//
//  FirebaseDemoProjectsApp.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2023/12/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct FirebaseDemoProjectsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                AuthenticatedView {
                    Image(systemName: "number.circle.fill")
                        .resizable()
                        .frame(width: 100 , height: 100)
                        .foregroundColor(Color(.systemPink))
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .clipped()
                        .padding(4)
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    Text("Welcome to Favourites!")
                        .font(.title)
                    Text("You need to be logged in to use this app.")
                } content: {
                    FavouriteNumberView()
                    Spacer()
                }
            }
        }
    }
}
