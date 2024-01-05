//
//  Restaurant.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/05.
//

import Foundation
import FirebaseFirestore


struct Restaurant: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var address: String
    var dateAdded: Timestamp
}

class RestaurantStore: ObservableObject {
    static let shared = RestaurantStore()
    
    init() {}
    
    @Published var restaurants = [Restaurant]()
    let db = Firestore.firestore()
    func feetchRestaurant() {
        let docRef = db.collection("Restaurants").document("PizzaMania")
        docRef.getDocument { document, error in
            guard error == nil else { return }
            if let document = document, document.exists {
                let data = document.data()
                print("data:", data)
                self.restaurants.append(Restaurant(id: "", name: data?["name"] as? String ?? "", address: data?["address"] as? String ?? "", dateAdded: data?["dateAdded"] as? Timestamp ?? Timestamp()))
            }
        }
    }
}

