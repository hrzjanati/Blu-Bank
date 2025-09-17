//
//  TransfreDetails.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//

import UIKit
import Foundation
import Combine

extension TransfreDetailsViewController {
    class ViewModel : BaseViewModel {
        // MARK: - ----------------- Propertires
        @Published var transferItem : TransfreListModel
        
        private let favoritesManager: FavoritesManager<TransfreListModel>
        
        let networkService: NetworkServiceProtocol
        var cancellables = Set<AnyCancellable>()
        // MARK: - ----------------- Init
        init(_ transferItem: TransfreListModel ,
             favoritesManager : FavoritesManager<TransfreListModel> ,
             networkService: NetworkServiceProtocol) {
            self.transferItem = transferItem
            self.favoritesManager = favoritesManager
            self.networkService = networkService
            super.init()
        }
        // MARK: - ----------------- Fetch Image
        func fetchAvatarImage(completion: @escaping (UIImage?) -> Void) {
            let urlString = transferItem.person.avatar
            networkService.requestImage(urlString)
                .receive(on: DispatchQueue.main)
                .sink { image in
                    completion(image ?? UIImage(systemName: "person.circle"))
                }
                .store(in: &cancellables)
        }
    }
}
// MARK: - ----------------- Favorite Manager
extension TransfreDetailsViewController.ViewModel {
    func isFavorite() -> Bool {
        return favoritesManager.isFavorite(transferItem)
    }
    
    func toggleFavorite() {
        favoritesManager.toggle(transferItem)
    }
}
