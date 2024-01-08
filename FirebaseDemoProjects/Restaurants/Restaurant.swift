//
//  Restaurant.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/05.
//

import Foundation
import Firebase
import FirebaseFirestore


struct Restaurant: Codable, Hashable {
    var name: String
    var address: String
    var dateAdded: Timestamp
    
    init(name: String, address: String, dateAdded: Timestamp = Timestamp(date: Date())) {
        self.name = name
        self.address = address
        self.dateAdded = dateAdded
    }
}

class RestaurantStore: ObservableObject {
    static let shared = RestaurantStore()
    
    private init() {}
    
    @Published var restaurants = [Restaurant]()
    let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    @MainActor
    func fetchAllRestaurant() async {
        do {
            let snapshot = try await db.collection("Restaurants").getDocuments()
            
            // 이거 안해주면 load 할 때마다 와랄라 다 출력된다!(버튼 누를 때마다 리스트 계속 반복된다는 뜻)
            self.restaurants.removeAll()
            
            for document in snapshot.documents {
                // TODO: 수정해보기
                if let rest = try? document.data(as: Restaurant.self) {
                    self.restaurants.append(rest)
                    print("data", rest)
                }
            }
        } catch {
            print(error)
        }
    }
    
    // 컬렉션에 문서 데이터 추가하기
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
//        let documentData: [String: Any] = [
//            "name": restaurant.name,
//            "address": restaurant.address,
//            "dateAdded": Timestamp(date: Date())
//        ]
//        addRestaurant(docName: restaurant.name, documentData: documentData)
        try? db.collection("Restaurants").document(restaurant.name).setData(from: restaurant)
    }
    
    // MARK: Update
    func updateRestaurant(restaurantName: String, restaurantAddress: String) {
        let docRef = db.collection("Restaurants").document(restaurantName)
//        docRef.setData( ["address": restaurantAddress], merge: true) { error in
//            if let error = error {
//                print("Error writing document:", error)
//            } else {
//                print("Success merged.")
//            }
//        }
        docRef.updateData(["address": restaurantAddress]) { error in
            if let error = error {
                print(error)
            } else {
                print("Successed merged:", restaurantName)
            }
        }
    }
    
    //MARK: delete
    func deleteRestaurant(restaurantName: String) {
        let docRef = db.collection("Restaurants").document(restaurantName)
        docRef.delete() { error in
            if let error = error {
                print("Error deleting document:", error)
            } else {
                print("Successed deleted.")
            }
        }
    }
    
    // MARK: Query
    // 가게 이름으로 쿼리문 실행하기
    func findRestaurantStore(restaurantName: String) async {
        do {
            let snapshot = try await db.collection("Restaurants").whereField("name", isEqualTo: restaurantName).getDocuments()
            self.restaurants.removeAll()
            for document in snapshot.documents {
                print("data", document.data())
                if let rest = try? document.data(as: Restaurant.self) {
                    self.restaurants.append(rest)
                }
            }
        } catch {
            print(error)
        }
    }
    
    // 실시간 업데이트 가져오기
    func startListening() {
        listener =
        db.collection("Restaurants").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if diff.type == .added {
                    if let rest = try? diff.document.data(as: Restaurant.self) {
                        self.restaurants.append(rest)
                        print("[add data]", rest)
                    }
                }
                if diff.type == .modified {
                    if let rest = try? diff.document.data(as: Restaurant.self) {
                        for (index, item) in self.restaurants.enumerated() where rest.name  == item.name {
                            self.restaurants[index] = rest
                        }
                    }
                }
                if diff.type == .removed {
                    if let rest = try? diff.document.data(as: Restaurant.self) {
                        for (index, item) in self.restaurants.enumerated() where rest.name == item.name {
                            self.restaurants.remove(at: index)
                        }
                    }
                }
            }
        }
        
    }
    
    // 실시간 관찰 중지
    func stopListening() {
        listener?.remove()
        print("stopListening")
    }
}

