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
            
            HStack {
                Button("Add") {
                    restaurantStore.addRestaurant(restaurant:
                                Restaurant(
                                    name: name,
                                    address: address
                                    ))
                }
                
                Button("Update") {
                    restaurantStore.updateRestaurant(restaurantName: name, restaurantAddress: address)
                }
                
                Button("Delete") {
                    restaurantStore.deleteRestaurant(restaurantName: name)
                }
            }
            
            Button("Load") {
                Task {
                   await restaurantStore.fetchAllRestaurant()
                }
            }
            
            Button("Find") {
                Task {
                    await restaurantStore.findRestaurantStore(restaurantName: name)
                }
            }
            
            Spacer()
            List {
                ForEach(restaurantStore.restaurants, id: \.self) { restaurant in
                    HStack {
                        Text(restaurant.name)
                        Spacer()
                        Text(restaurant.address)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        restaurantStore.deleteRestaurant(restaurantName: restaurantStore.restaurants[index].name)
                    }
                })
            }
        }
        .onAppear {
            self.restaurantStore.startListening()
        }
        .onDisappear {
            self.restaurantStore.stopListening()
        }
    }
}

#Preview {
    FireStoreView()
}
