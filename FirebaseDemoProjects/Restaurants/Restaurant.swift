//
//  Restaurant.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/05.
//

import Foundation
import Firebase
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
    func feetchAllRestaurant() {
       db.collection("Restaurants").getDocuments() { (snapshot, error) in
            guard error == nil else { return }
           
            self.restaurants.removeAll()
           
            for document in snapshot!.documents {
                let data = document.data()
                print("data:", data)
                self.restaurants.append(Restaurant(id: "", name: data["name"] as? String ?? "", address: data["address"] as? String ?? "", dateAdded: data["dateAdded"] as? Timestamp ?? Timestamp()))
            }
        }
    }
    
    func addRestaurant(docName: String, documentData: [String: Any]) {
        let docRef = db.collection("Restaurants").document(docName)
        docRef.setData(documentData) { error in
            if let error = error {
                print(error)
            } else {
                print("Success:", docName)
            }
        }
    }
    
    func addRestaurant(restaurant: Restaurant) {
        let documentData: [String: Any] = [
            "name": restaurant.name,
            "address": restaurant.address,
            "dateAdded": Timestamp(date: Date())
        ]
        addRestaurant(docName: restaurant.name, documentData: documentData)
    }
}

