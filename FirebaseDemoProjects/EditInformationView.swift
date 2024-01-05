//
//  EditInformationView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/04.
//

import SwiftUI

struct EditInformationView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productStore = ProductStore.shared
    @State var name: String = ""
    @State var description: String = ""
    @State var isOrder: Bool = false
    @Binding var selectedProduct: Product
    var body: some View {
        VStack(spacing: 50) {
            VStack(alignment: .leading) {
                Text("Product Name")
                    .font(.title)
                    .bold()
                TextField("이름", text: $selectedProduct.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            VStack(alignment: .leading) {
                Text("Product description")
                    .font(.title)
                    .bold()
                TextField("제품 설명", text: $selectedProduct.description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Spacer()
            // TODO: dismiss 추가하기
            Button {
                let editProduct = Product(id: selectedProduct.id, name: selectedProduct.name, description: selectedProduct.description, isOrder: selectedProduct.isOrder)
                productStore.updateProduct(item: editProduct)
                dismiss()
            } label: {
                Text("수정 완료하기")
            }
            Spacer()
        }
        .padding()
    }
}

//#Preview {
//    EditInformationView()
//}
