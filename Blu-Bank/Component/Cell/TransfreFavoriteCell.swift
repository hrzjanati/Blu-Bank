//
//  TransfreFavoriteCell.swift
//  Blu-Bank
//
//  Created by Nik on 16/09/2025.
//

import SwiftUI

struct TransfreFavoriteCell: View {
    // MARK: - ----------------- Properties
    @State var name: String?
    @State var identifier: String?
    // MARK: - ----------------- View
    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 40, height: 40)
            
            Text(name ?? "Not Found")
                .font(.caption)
            
            Text(identifier ?? "Not Found")
                .font(.footnote)
            
                .padding(.horizontal)
        }
    }
}
// MARK: - ----------------- Preview
#Preview {
    TransfreFavoriteCell(name: "Hossein", identifier: "identifire 1")
}
