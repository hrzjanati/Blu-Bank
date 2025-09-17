//
//  TransfreFavoriteCell.swift
//  Blu-Bank
//
//  Created by Nik on 16/09/2025.
//

import SwiftUI
import Combine

struct TransfreFavoriteCell: View {
    // MARK: - ----------------- Properties
    var name: String?
    var identifier: String?
    var avatarURL: String?
    var networkService: NetworkServiceProtocol
    
    @State private var avatarImage: UIImage? = nil
    @State private var isLoadingImage = true
    @State private var cancellables = Set<AnyCancellable>()
    
    // MARK: - ----------------- View
    var body: some View {
        VStack {
            viewAvatarImage()
            
            Text(name ?? "Not Found")
                .font(.caption)
            
            Text(identifier ?? "Not Found")
                .font(.footnote)
                .padding(.horizontal)
        }
        .onAppear {
            loadImage()
        }
    }
    
    // MARK: - ----------------- Load Image
    private func loadImage() {
        guard let urlString = avatarURL else { return }
        isLoadingImage = true
        networkService.requestImage(urlString)
            .receive(on: DispatchQueue.main)
            .sink { image in
                self.avatarImage = image ?? UIImage(systemName: "person.circle")
                self.isLoadingImage = false
            }
            .store(in: &cancellables)
    }
    
    // MARK: - ----------------- View Avatar Image
    private func viewAvatarImage() -> some View {
        ZStack {
            if isLoadingImage {
                ProgressView()
                    .frame(width: 60, height: 60)
            } else {
                Image(uiImage: avatarImage ?? UIImage(systemName: "person.circle")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
        }
    }
}

// MARK: - ----------------- Preview
#Preview {
    TransfreFavoriteCell(name: "Hossein",
                         identifier: "identifire 1",
                         networkService: NetworkService())
}
