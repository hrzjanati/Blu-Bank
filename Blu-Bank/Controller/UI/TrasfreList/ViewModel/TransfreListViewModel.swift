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
        // MARK: - ----------------- Propertires
        @Published var transferList: [TransfreListModel]
        @Published var isLoading : Bool
        @Published var errorMessage: String?
        
        var cancellables = Set<AnyCancellable>()
        
        private let provider: TransfreListDIProvider
        // MARK: - ----------------- Init
        init(provider: TransfreListDIProvider) {
            self.provider = provider
            self.isLoading = provider.isLoading
            transferList = provider.transfreList
            super.init()
        }
        /// Fetch API Transfre List
        func fetchTransferList(_ page: Int) -> AnyPublisher<[TransfreListModel], NetworkError> {
            isLoading = true
            let router = TransferListRouter.transferList(page: page)
            
            return provider.networkService.request(router)
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                }, receiveCancel: { [weak self] in
                    self?.isLoading = false
                })
                .eraseToAnyPublisher()
        }
    }
}
