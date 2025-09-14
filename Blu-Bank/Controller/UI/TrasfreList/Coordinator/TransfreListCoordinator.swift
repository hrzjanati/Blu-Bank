//
//  TransfreList.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import UIKit

class TransfreListCoordinator {
    // MARK: - ----------------- Properties
    var navigationController: UINavigationController?
    // MARK: - ----------------- Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    // MARK: - ----------------- Start
    func start() {
        // Resolve from DI container
        guard let vc = AppDIContainer.shared.container.resolve(TransfreListViewController.self) else {
            fatalError("TransferListViewController dependency not found")
        }
        vc.coordinator = self
        vc.navigationItem.title = "Transfer List"
        navigationController?.pushViewController(vc, animated: true)
    }
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}
