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
        guard let navigationController = navigationController else { return }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        startFirstVC()
    }
    
    private func startFirstVC() {
        guard let navigationController = navigationController else { return }
        HomeCoordinator(navigationController: navigationController).start()
    }
}
