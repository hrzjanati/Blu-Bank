//
//  TransfreList.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//
import UIKit
import Foundation
import Combine
import SwiftUI

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
            isRefreshing = true
            currentPage = 1
            hasMore = true
            
            let router = TransferListRouter.transferList(page: currentPage)
            
            networkService.request(router)
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveCompletion: { [weak self] _ in
                    self?.isRefreshing = false
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
                            self.transferList = transfers
                        }
                    }
                    
                    if transfers.count < self.pageSize {
                        self.hasMore = false
                    }
                    self.currentPage += 1
                })
                .store(in: &cancellables)
        }
        
        // MARK: - Private Fetch
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
}
