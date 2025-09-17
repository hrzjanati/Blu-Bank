//
//  TransfreList.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit
import Swinject

class TransfreListCoordinator : ObservableObject {
    // MARK: - ----------------- Properties
    var navigationController: UINavigationController?
    let resolver: Resolver
    // MARK: - ----------------- Init
    init(navigationController: UINavigationController , resolver: Resolver = AppDIContainer.shared.container.synchronize()) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    // MARK: - ----------------- Start
    func start() {
        // Resolve from DI container
        guard let vc = resolver.resolve(TransfreListViewController.self) else { return }
        vc.coordinator = self
        vc.navigationItem.title = "Transfer List"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    func showDetails(for transfer: TransfreListModel) {
        guard let navigationController else { return }
        let coordinator = TransfreDetailsCoordinator(navigationController: navigationController,
                                                     resolver: resolver,
                                                     transferItem: transfer)
        coordinator.start()
    }
}
