//
//  ContentView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2023/12/22.
//

import SwiftUI


struct ContentView: View {
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
            List {
                ForEach(productStore.products, id: \.self) { product in
                    Text(product.name)
                }
                // MARK: indexSet의 정체는 뭐니?
                .onDelete(perform: { indexSet in
                    if let indexSet = indexSet.first {
                        print(productStore.products[indexSet].id)
                        self.productStore.deleteProduct(key: productStore.products[indexSet].id)
                    }
                })
            }
        }
        .padding()
        .onAppear {
            self.productStore.listenToRTDatabase()
        }
        .onDisappear {
            self.productStore.stopListening()
        }
    }
}

#Preview {
    ContentView()
}
