//
//  TransferListCell.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import SwiftUI
import Combine

struct TransferListCell: View {
    // MARK: - ----------------- Properties
    var name: String?
    var identifier: String?
    var avatarURL: String?
    var networkService: NetworkServiceProtocol
    var isFavorite: Bool?
    
    @State private var avatarImage: UIImage? = nil
    @State private var isLoadingImage = true
    @State private var cancellables = Set<AnyCancellable>()
    
    // MARK: - ----------------- View
    var body: some View {
        HStack {
            viewAvatarImage()
            
            VStack(alignment: .leading) {
                Text(name ?? "Not Found")
                Text(identifier ?? "Not Found")
            }
            .padding(.horizontal)
            
            Spacer()
            
            if isFavorite ?? false {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            
            Image(systemName: "chevron.right")
                .frame(width: 20, height: 20)
        }
        .padding()
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
                    .frame(width: 40, height: 40)
            } else {
                Image(uiImage: avatarImage ?? UIImage(systemName: "person.circle")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
        }
    }
}

// MARK: - ----------------- Preview
#Preview {
    TransferListCell(name: "Hossein",
                     identifier: "identifire 1",
                     networkService: NetworkService())
}
