//
//  ContentView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2023/12/22.
//

import SwiftUI


struct AddProductView: View {
    @ObservedObject var productStore = ProductStore.shared
    @State var name: String = ""
    @State var description: String = ""
    @State var isOrder: Bool = false
    
    var body: some View {
        VStack {
            TextField("이름", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("제품 설명", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                productStore.addProduct(item: Product(id: UUID().uuidString, name: name, description: description, isOrder: isOrder))
            } label: {
                Text("Add Product")
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddProductView()
}
