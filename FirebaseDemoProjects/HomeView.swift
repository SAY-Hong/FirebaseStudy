//
//  HomeView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/04.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var productStore = ProductStore.shared
//    @StateObject var productInformation: ProductStore = ProductStore()
    var body: some View {
        NavigationStack {
            List {
                ForEach(productStore.products, id: \.self) { product in
                    NavigationLink {
                        ProductDetailView(productInformation: product)
                    } label: {
                        Text(product.name)
                    }
                }
                // MARK: indexSet의 정체는 뭐니?
                .onDelete(perform: { indexSet in
                    if let indexSet = indexSet.first {
                        print(productStore.products[indexSet].id)
                        self.productStore.deleteProduct(key: productStore.products[indexSet].id)
                    }
                })
            }
            .navigationBarTitle("Product List")
            .toolbar {
                NavigationLink {
                    AddProductView()
                } label: {
                    Text("추가하기")
                }

            }
        }
        .onAppear {
            self.productStore.listenToRTDatabase()
        }
        .onDisappear {
            self.productStore.stopListening()
        }
    }
}

#Preview {
    HomeView()
}
