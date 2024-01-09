//
//  AddRecordView.swift
//  FirebaseDemoProjects
//
//  Created by 홍세희 on 2024/01/08.
//

import SwiftUI

struct AddRecordView: View {
    @ObservedObject var recordings = Recordings.shared
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Text("여기다가 감정을 표출해보세요!")
            TextField("느낀 감정을 적어보세요", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
        }
        .padding()
    }
}

#Preview {
    AddRecordView()
}
