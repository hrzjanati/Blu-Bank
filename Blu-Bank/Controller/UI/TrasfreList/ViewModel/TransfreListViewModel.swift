//
//  TransfreList.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import Combine
import SwiftUI

extension TransfreListViewController {
    class ViewModel: BaseViewModel {
        // MARK: - ----------------- Properties
        @Published var transferList: [TransfreListModel] = []
        @Published var favoriteList: [TransfreListModel] = []
        @Published var isLoading = false
        @Published var isRefreshing = false
        
        private var cancellables = Set<AnyCancellable>()
        private(set) var currentPage = 1
        private(set) var hasMore = true
        private let pageSize = 10
      
        let networkService: NetworkServiceProtocol
        let favoritesManager: FavoritesManager<TransfreListModel>
        
        // MARK: - ----------------- Init
        init(networkService: NetworkServiceProtocol,
             favoritesManager: FavoritesManager<TransfreListModel>) {
            self.networkService = networkService
            self.favoritesManager = favoritesManager
            super.init()
            favoriteList = favoritesManager.all()
            subscribeFavoriteList()
        }
    }
}
// MARK: - ----------------- Function for Api Call And Fech Data
extension TransfreListViewController.ViewModel {
    func loadFirstPage() {
        currentPage = 1
        hasMore = true
        transferList.removeAll()
        fetchTransferList(page: currentPage)
    }
    
    func fetchNextPage() {
        guard hasMore, !isLoading else { return }
        fetchTransferList(page: currentPage)
    }
    
    func refreshList() {
        isRefreshing = true
        loadFirstPage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isRefreshing = false
        }
    }
    
    private func fetchTransferList(page: Int) {
        guard !isLoading, hasMore else { return }
        isLoading = true
        
        let router = TransferListRouter.transferList(page: page)
        
        networkService.request(router)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case .failure(let error) = completion {
                    print("Transfer list error: \(error)")
                }
            } receiveValue: { [weak self] (transfers: [TransfreListModel]) in
                guard let self = self else { return }
                
                // Filter duplicates based on id
                let newTransfers = transfers.filter { transfer in
                    !self.transferList.contains { $0.id == transfer.id }
                }
                
                // Append with animation
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.transferList.append(contentsOf: newTransfers)
                }
                
                // Update pagination
                self.hasMore = transfers.count >= self.pageSize
                if !newTransfers.isEmpty {
                    self.currentPage += 1
                }
            }
            .store(in: &cancellables)
    }
    
}
// MARK: - ----------------- Manage Favorite
extension TransfreListViewController.ViewModel {
    func subscribeFavoriteList() {
        favoritesManager.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.favoriteList = items
            }
            .store(in: &cancellables)
    }
    
    func toggleFavorite(_ item: TransfreListModel) {
        favoritesManager.toggle(item)
        favoriteListUpdate()
    }
    
    func isFavorite(_ item: TransfreListModel) -> Bool {
        favoritesManager.isFavorite(item)
    }
    
    func favoriteListUpdate() {
        favoriteList = favoritesManager.all()
    }
}
