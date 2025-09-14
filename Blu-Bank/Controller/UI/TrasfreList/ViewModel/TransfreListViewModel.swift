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
        private let provider: TransfreListDIProvider
        var cancelBage = CancelBag()
        var isLoading : Bool
        // MARK: - ----------------- Init
        init(provider: TransfreListDIProvider) {
            self.provider = provider
            self.isLoading = provider.isLoading
            super.init()
        }
        
        func fetchTransferList(_ page: Int) -> AnyPublisher<[TransfreListModel], NetworkError> {
            isLoading = true
            let router = TransferListRouter.transferList(page: page)
            
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
