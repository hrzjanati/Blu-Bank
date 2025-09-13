//
//  AppCoordinator.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import UIKit
class AppCoordinator: Coordinator {
    // MARK: - ----------------- Properties
    var navigationController: UINavigationController?
    let window: UIWindow
    
    // MARK: - ----------------- Init
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    // MARK: - ----------------- Start
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let homeVC = AppDIContainer.shared.container.resolve(HomeViewController.self)!
        navigationController?.pushViewController(homeVC, animated: true)
    }
}
