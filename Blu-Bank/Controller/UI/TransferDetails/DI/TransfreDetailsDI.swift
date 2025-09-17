//
//  TransfreDetails.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//

import Swinject
import UIKit

class TransfreDetailsAssembly: Assembly {
    func assemble(container: Container) {
        // Register FavoritesManager as singleton
        container.register(FavoritesManager<TransfreListModel>.self) { _ in
            FavoritesManager<TransfreListModel>(key: "favorites_list")
        }.inObjectScope(.container)
        
        // Register NetworkService
        container.register(NetworkServiceProtocol.self) { _ in
            NetworkService()
        }.inObjectScope(.container)
        
        // Register ViewController (without vm)
        container.register(TransfreDetailsViewController.self) { _ in
            TransfreDetailsViewController()
        }.inObjectScope(.transient)
        
        // Register Coordinator
        container.register(TransfreDetailsCoordinator.self) { (resolver, navigationController: UINavigationController, transferItem: TransfreListModel) in
            let coordinator = TransfreDetailsCoordinator(navigationController: navigationController,
                                                         resolver: resolver,
                                                         transferItem: transferItem)
            return coordinator
        }.inObjectScope(.transient)
    }
}
