//
//  HomeDI.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import Swinject

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        // Provider
        container.register(HomeDIProvider.self) { _ in
            HomeDIProviding()
        }
        // ViewModel
        container.register(HomeViewController.ViewModel.self) { resolver in
            guard let provider = resolver.resolve(HomeDIProvider.self) else {
                fatalError("⚠️ HomeDIProvider dependency not found")
            }
            return HomeViewController.ViewModel( provider: provider)
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
/// If some properties require default/initial values, you can manage them
/// through a Provider and inject into ViewModel or ViewController.
/// This approach helps keep dependencies decoupled and maintainable.
// MARK: - ----------------- Home Provider
protocol HomeDIProvider {
    var isLoading: Bool { get }
    var networkService: NetworkServiceProtocol { get }
}
// MARK: - ----------------- Home Providing
class HomeDIProviding: HomeDIProvider {
    // Inject init value
    var isLoading: Bool = false
    // Inject network service
    var networkService: NetworkServiceProtocol {
        NetworkService()
    }
}
