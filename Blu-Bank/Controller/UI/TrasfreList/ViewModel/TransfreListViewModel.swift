//
//  TransfreList.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit
import Foundation
import Combine

extension TransfreListViewController {
    class ViewModel: BaseViewModel {
        // MARK: - Properties
        @Published var transferList: [TransfreListModel] = []
        @Published var isLoading: Bool = false
        @Published var isRefreshing: Bool = false
        
        var cancellables = Set<AnyCancellable>()
        private let networkService: NetworkServiceProtocol
        
        private var currentPage: Int = 1
        private let pageSize: Int = 10
        private var hasMore: Bool = true
        
        // MARK: - Init
        init(networkService: NetworkServiceProtocol) {
            self.networkService = networkService
            super.init()
        }
        
        // MARK: - Fetch Page
        func fetchNextPageIfNeeded(currentItem: TransfreListModel?) {
            guard let currentItem else {
                fetchTransferList(page: 1)
                return
            }
            
            guard let lastIndex = transferList.firstIndex(where: { $0.id == currentItem.id }) else { return }
            let thresholdIndex = transferList.index(transferList.endIndex, offsetBy: -3)
            
            guard lastIndex >= thresholdIndex else { return }
            guard hasMore, !isLoading else { return }
            
            fetchTransferList(page: currentPage)
        }
        
        // MARK: - Refresh
        func refreshList() {
            currentPage = 1
            hasMore = true
            transferList.removeAll()
            isRefreshing = true
            fetchTransferList(page: currentPage)
        }
        
        // MARK: - Private Fetch
        private func fetchTransferList(page: Int) {
            isLoading = true
            let router = TransferListRouter.transferList(page: page)
            
            networkService.request(router)
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                    self?.isRefreshing = false
                })
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Transfer list error: \(error)")
                    }
                }, receiveValue: { [weak self] (transfers: [TransfreListModel]) in
                    guard let self else { return }
                    
                    if transfers.count < self.pageSize {
                        self.hasMore = false
                    }
                    self.transferList.append(contentsOf: transfers)
                    self.currentPage += 1
                })
                .store(in: &cancellables)
        }
    }
}
