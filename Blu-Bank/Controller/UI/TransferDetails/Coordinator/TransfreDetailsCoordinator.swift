//
//  TransfreDetails.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//

import UIKit
import Swinject

class TransfreDetailsCoordinator {
    // MARK: - ----------------- Properties
    var navigationController: UINavigationController?
    let resolver: Resolver
    var transferItem : TransfreListModel
    // MARK: - ----------------- Init
    init(navigationController: UINavigationController , resolver: Resolver = AppDIContainer.shared.container.synchronize() ,  transferItem : TransfreListModel) {
        self.navigationController = navigationController
        self.resolver = resolver
        self.transferItem = transferItem
    }
    // MARK: - ----------------- Start
    func start() {
        guard let vc = resolver.resolve(TransfreDetailsViewController.self) else { return }
        let favoritesManager = resolver.resolve(FavoritesManager<TransfreListModel>.self)!
        let networkService = resolver.resolve(NetworkServiceProtocol.self)!
        vc.vm = TransfreDetailsViewController.ViewModel(transferItem,
                                                        favoritesManager: favoritesManager,
                                                        networkService: networkService)
        vc.coordinator = self
        vc.navigationItem.title = "Transfer Details"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}
