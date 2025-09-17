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
        
        var cancellables = Set<AnyCancellable>()
        // MARK: - ----------------- Init
        init(_ transferItem: TransfreListModel , favoritesManager : FavoritesManager<TransfreListModel> ) {
            self.transferItem = transferItem
            self.favoritesManager = favoritesManager
            super.init()
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
