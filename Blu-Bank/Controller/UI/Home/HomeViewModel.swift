//
//  HomeViewModel.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import Foundation
import Combine

extension HomeViewController {
    class ViewModel : BaseViewModel {
        // MARK: - ----------------- Propertires
        private let provider: HomeDIProvider
        var isLoading : Bool
        // MARK: - ----------------- Init
        init(provider: HomeDIProvider) {
            self.provider = provider
            self.isLoading = provider.isLoading
            super.init()
        }
        
        
        
        func fetchTransferList(_ page: Int) -> AnyPublisher<[TransferModel], NetworkError> {
            isLoading = true
            let router = TransferRouter.transferList(page: page)
            
            return provider.networkService.request(router)
                .handleEvents(receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                }, receiveCancel: { [weak self] in
                    self?.isLoading = false
                })
                .eraseToAnyPublisher()
        }
        
        
    }
}
