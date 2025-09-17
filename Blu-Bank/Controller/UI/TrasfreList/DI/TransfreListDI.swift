//
//  TransfreList.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import Swinject
import UIKit

// MARK: - ----------------- Assembly
class TransfreListAssembly: Assembly {
    func assemble(container: Container) {
        // Register FavoritesManager as a singleton
        container.register(FavoritesManager<TransfreListModel>.self) { _ in
            FavoritesManager<TransfreListModel>(key: "favorites_list")
        }
        .inObjectScope(.container)
        // ViewModel
        container.register(TransfreListViewController.ViewModel.self) { resolver in
            let networkService = resolver.resolve(NetworkServiceProtocol.self)!
            let favoritesManager = resolver.resolve(FavoritesManager<TransfreListModel>.self)!
            return TransfreListViewController.ViewModel(networkService: networkService,
                                                        favoritesManager: favoritesManager)
        }.inObjectScope(.transient)
        
        // ViewController
        container.register(TransfreListViewController.self) { resolver in
            let vc = TransfreListViewController()
            vc.vm = resolver.resolve(TransfreListViewController.ViewModel.self)
            return vc
        }.inObjectScope(.transient)
    }
}
