//
//  HomeDI.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import Swinject

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeViewController.ViewModel.self) { resolver in
            //    let apiService = resolver.resolve(APIService.self)!
            return HomeViewController.ViewModel(userName: "Hossein")
        }
        
        container.register(HomeViewController.self) { resolver in
            let vc = HomeViewController()
            vc.coordinator = resolver.resolve(HomeCoordinator.self)
            vc.vm = resolver.resolve(HomeViewController.ViewModel.self)
            return vc
        }
    }
}
