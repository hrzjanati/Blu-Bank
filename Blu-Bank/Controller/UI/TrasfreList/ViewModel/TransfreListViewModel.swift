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
        
        private let favoritesManager = FavoritesManager<TransfreListModel>(key: "favorites_list")
        private var cancellables = Set<AnyCancellable>()
        private let networkService: NetworkServiceProtocol
        private(set) var currentPage = 1
        private(set) var hasMore = true
        private let pageSize = 10
        
        // MARK: - ----------------- Init
        init(networkService: NetworkServiceProtocol) {
            self.networkService = networkService
            favoriteList = favoritesManager.all()
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
        isLoading = true
        let router = TransferListRouter.transferList(page: page)
        
        networkService.request(router)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Transfer list error: \(error)")
                }
            }, receiveValue: { [weak self] (transfers: [TransfreListModel]) in
                guard let self else { return }
                
                let newTransfers = transfers.filter { newTransfer in
                    !self.transferList.contains { $0.id == newTransfer.id }
                }
                
                if !newTransfers.isEmpty {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.transferList.append(contentsOf: newTransfers)
                    }
                } else {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.transferList.append(contentsOf: transfers)
                    }
                }
                
                if transfers.count < self.pageSize {
                    self.hasMore = false
                }
                
                self.currentPage += 1
            })
            .store(in: &cancellables)
    }
}
// MARK: - ----------------- Manage Favorite
extension TransfreListViewController.ViewModel {
    func toggleFavorite(_ item: TransfreListModel) {
        favoritesManager.toggle(item)
    }
    
    func isFavorite(_ item: TransfreListModel) -> Bool {
        favoritesManager.isFavorite(item)
    }
    func favoriteListUpdate() {
        favoriteList = favoritesManager.all()
    }
}
