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
    class ViewModel : BaseViewModel {
        // MARK: - ----------------- Properties
        @Published private(set) var transferList: [TransfreListModel] = []
        @Published private(set) var isLoading: Bool = false
        @Published private(set) var hasMore: Bool = true
        
        private var currentPage: Int = 1
        private let pageSize: Int = 10
        private let networkService: NetworkServiceProtocol
        var cancellables = Set<AnyCancellable>()
        // MARK: - ----------------- Init
        init(networkService: NetworkServiceProtocol) {
            self.networkService = networkService
            super.init()
        }
        
        /// Fetch API Transfre List
        func fetchTransferList(reset: Bool = false) {
            guard !isLoading, hasMore else { return }
            
            if reset {
                transferList = []
                currentPage = 1
                hasMore = true
            }
            
            isLoading = true
            let router = TransferListRouter.transferList(page: currentPage)
            
            networkService.request(router)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
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
