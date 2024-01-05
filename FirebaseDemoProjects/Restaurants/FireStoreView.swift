//
//  FireStoreView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/05.
//

import SwiftUI
import FirebaseFirestore

struct FireStoreView: View {
    @ObservedObject var restaurantStore = RestaurantStore.shared
    @State var name: String = ""
    @State var address: String = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Address", text: $address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            Button {
                restaurantStore.addRestaurant(restaurant:
                            Restaurant(
                                id: "",
                                name: name,
                                address: address,
                                dateAdded: Timestamp()))
            } label: {
                Text("Add")
            }
            
            Button {
                restaurantStore.feetchAllRestaurant()
            } label: {
                Text("Load")
            }
            Spacer()
            List {
                ForEach(restaurantStore.restaurants, id: \.self) { restaurant in
                    Text(restaurant.name)
                }
            }
        }
    }
}

#Preview {
    FireStoreView()
}
