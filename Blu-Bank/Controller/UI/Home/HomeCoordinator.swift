//
//  HomeCoordinator.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import UIKit

class HomeCoordinator: Coordinator {
    // MARK: - ----------------- Properties
    var navigationController: UINavigationController?
    // MARK: - ----------------- Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController?.view.semanticContentAttribute = .forceRightToLeft
    }
    // MARK: - ----------------- Start
    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        vc.navigationItem.title = "Home Transfer List"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}
