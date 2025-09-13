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
        var userName : String?
        // MARK: - ----------------- Init
        init(userName : String) {
            self.userName = userName
            super.init()
        }
    }
}
