//
//  TransfreFavoriteCell.swift
//  Blu-Bank
//
//  Created by Nik on 16/09/2025.
//

import SwiftUI

struct TransfreFavoriteCell: View {
    @State var name: String?
    @State var identifier: String?
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 40, height: 40)
          
                Text(name ?? "Not Found")
                Text(identifier ?? "Not Found")
            
            .padding(.horizontal)
        }
        
        
    }
}

#Preview {
    TransfreFavoriteCell(name: "Hossein", identifier: "identifire 1")
}
