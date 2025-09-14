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
        
        // MARK: - Provider
        container.register(TransfreListDIProvider.self) { _ in
            TransfreListDIProviding()
        }.inObjectScope(.container) // singleton scope
        
   
        
        // MARK: - ViewModel
        container.register(TransfreListViewController.ViewModel.self) { resolver in
            guard let provider = resolver.resolve(TransfreListDIProvider.self) else {
                fatalError("⚠️ TransfreListDIProvider dependency not found")
            }
            return TransfreListViewController.ViewModel(provider: provider)
        }
        
        // MARK: - ViewController
        container.register(TransfreListViewController.self) { resolver in
            let vc = TransfreListViewController()
            vc.coordinator = resolver.resolve(TransfreListCoordinator.self)
            vc.vm = resolver.resolve(TransfreListViewController.ViewModel.self)
            return vc
        }
    }
}

// MARK: - ----------------- Provider Protocol
protocol TransfreListDIProvider {
    var isLoading: Bool { get }
    var networkService: NetworkServiceProtocol { get }
}

// MARK: - ----------------- Provider Implementation
class TransfreListDIProviding: TransfreListDIProvider {
    let isLoading: Bool
    let networkService: NetworkServiceProtocol
    
    init(isLoading: Bool = false, networkService: NetworkServiceProtocol = NetworkService()) {
        self.isLoading = isLoading
        self.networkService = networkService
    }
}
