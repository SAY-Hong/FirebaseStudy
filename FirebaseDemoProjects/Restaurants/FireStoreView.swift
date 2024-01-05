//
//  FireStoreView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/05.
//

import SwiftUI

struct FireStoreView: View {
    @ObservedObject var restaurantStore = RestaurantStore.shared
    @State var name: String = ""
    @State var address: String = ""
    
    var body: some View {
        VStack {
            TextField("이름", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("이름", text: $address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                
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
