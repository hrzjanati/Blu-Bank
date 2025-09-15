//
//  TransferListCell.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import SwiftUI

struct TransferListCell: View {
    @State var name: String?
    @State var identifier: String?
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 40, height: 40)
            VStack {
                Text(name ?? "Not Found")
                Text(identifier ?? "Not Found")
            }
            .padding(.horizontal)
            Spacer()
            Image(systemName: "chevron.right")
                .frame(width: 20, height: 20)
        }
        .padding()
        
    }
}

#Preview {
    TransferListCell(name: "Hossein", identifier: "identifire 1")
}
