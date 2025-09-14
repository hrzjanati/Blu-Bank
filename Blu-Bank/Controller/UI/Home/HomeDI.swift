//
//  HomeDI.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import Swinject

// MARK: - ----------------- Home Assembly
class HomeAssembly: Assembly {
    func assemble(container: Container) {
        
        // NetworkService singleton
        container.register(NetworkServiceProtocol.self) { _ in
            NetworkService()
        }.inObjectScope(.container)
        
        // Provider
        container.register(HomeDIProvider.self) { resolver in
            let networkService = resolver.resolve(NetworkServiceProtocol.self)!
            return HomeDIProviding(networkService: networkService)
        }
        
        // ViewModel
        container.register(HomeViewController.ViewModel.self) { resolver in
            guard let provider = resolver.resolve(HomeDIProvider.self) else {
                fatalError("⚠️ HomeDIProvider dependency not found")
            }
            return HomeViewController.ViewModel(provider: provider)
        }
        
        // View
        container.register(HomeViewController.self) { resolver in
            let vc = HomeViewController()
            vc.coordinator = resolver.resolve(HomeCoordinator.self)
            vc.vm = resolver.resolve(HomeViewController.ViewModel.self)
            return vc
        }
    }
}

// MARK: - ----------------- Home Provider Protocol
protocol HomeDIProvider {
    var isLoading: Bool { get }
    var networkService: NetworkServiceProtocol { get }
}

// MARK: - ----------------- Home Provider Implementation
class HomeDIProviding: HomeDIProvider {
    var isLoading: Bool = false
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
