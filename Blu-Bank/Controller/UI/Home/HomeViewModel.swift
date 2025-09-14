//
//  HomeViewModel.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import Foundation

extension HomeViewController {
    class ViewModel : BaseViewModel {
        // MARK: - ----------------- Propertires
        private let provider: HomeDIProvider
        var isLoading : Bool
        let userName : String
        // MARK: - ----------------- Init
        init(userName: String, provider: HomeDIProvider) {
            self.userName = userName
            self.provider = provider
            self.isLoading = provider.isLoading
            super.init()
        }
    }
}
