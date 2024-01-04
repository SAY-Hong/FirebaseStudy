//
//  ProductDetailView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/04.
//

import SwiftUI

struct ProductDetailView: View {
    var productInformation: Product
    var body: some View {
        Form {
            Section(content: {
                Text(productInformation.name)
            }, header: {
                Text("Products Name")
            })
            Section(content: {
                Text(productInformation.description)
            }, header: {
                Text("Products description")
            })
            

        }
        .navigationTitle("\(productInformation.name)'s Info")
    }
}

#Preview {
    ProductDetailView(productInformation: Product(id: "1", name: "Coke", description: "스파클링이 많아요!", isOrder: true))
}
