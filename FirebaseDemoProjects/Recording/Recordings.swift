//
//  Recordings.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/08.
//
import Foundation
import Firebase
import FirebaseFirestore


struct Recording: Codable, Identifiable, Hashable {
    var id: UUID
    var text: String
    var recordTime: Timestamp
    
    init(id: UUID, text: String, recordTime: Timestamp = Timestamp(date: Date())) {
        self.id = UUID()
        self.text = text
        self.recordTime = recordTime
    }
}

class Recordings: ObservableObject {
    static let shared = Recordings()
    
    private init() {}
    
    @Published var recordings = [Recording]()
    let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    @MainActor
    
    func fetchAllRestaurant() async {
        do {
            let snapshot = try await db.collection("RecordingFeelings").getDocuments()
            
            // 이거 안해주면 load 할 때마다 와랄라 다 출력된다!(버튼 누를 때마다 리스트 계속 반복된다는 뜻)
            self.recordings.removeAll()
            
            for document in snapshot.documents {
                // TODO: 수정해보기
                if let record = try? document.data(as: Recording.self) {
                    self.recordings.append(record)
                    print("data", record)
                }
            }
        } catch {
            print(error)
        }
    }
    
    // 컬렉션에 문서 데이터 추가하기
    func addRestaurant(docName: String, documentData: [String: Any]) {
        let docRef = db.collection("RecordingFeelings").document(docName)
        docRef.setData(documentData) { error in
            if let error = error {
                print(error)
            } else {
                print("Success:", docName)
            }
        }
    }
    
    func addRestaurant(recording: Recording) {
//        let documentData: [String: Any] = [
//            "name": restaurant.name,
//            "address": restaurant.address,
//            "dateAdded": Timestamp(date: Date())
//        ]
//        addRestaurant(docName: restaurant.name, documentData: documentData)
        try? db.collection("RecordingFeelings").document(UUID().uuidString).setData(from: recording)
    }
}
