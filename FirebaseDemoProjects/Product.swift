//
//  Product.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/04.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class ProductStore: ObservableObject {
    static let shared = ProductStore()
    
    init() {}
    
    @Published var products = [Product]()
    
    // Realtime Database의 기본 경로를 저장하는 변수
    let ref: DatabaseReference? = Database.database().reference()
    
    // Realtime Database의 데이터 구조는 기본적으로 제이슨 형태
    // 저장소와 데이터를 주고 받을 때 제이슨 형식의 데이터로 주고 받기 때문에 Encoder, Decoder의 인스턴스가 필요
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // 데이터베이스를 실시간으로 관찰하여 데이터 변경 여부를 확인.
    // 실시간 데이터 읽기 쓰기가 가능하다.
    func listenToRTDatabase() {
        guard let dbPath = ref?.child("products") else { return }
        dbPath.observe(DataEventType.childAdded) { [weak self] snapshot in
            guard let self = self, let json = snapshot.value as? [String: Any] else {
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: json)
                let product = try self.decoder.decode(Product.self, from: data)
                self.products.append(product)
            } catch {
                print(error)
            }

        }
    }
    
    // 데이터베이스를 실시간으로 관찰하는 것을 중지.
    func stopListening() {
        ref?.removeAllObservers() // 등록되어있는 것들이 없어진다.
    }
    
    // 데이터베이스에 Product 인스턴스 추가
    func addProduct(item: Product) {
        self.ref?.child("products").child("\(item.id)").setValue([
            "id": item.id,
            "name": item.name,
            "description": item.description,
            "isOrder": item.isOrder
        ])
    }
}

struct Product: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var description: String
    var isOrder: Bool
}

