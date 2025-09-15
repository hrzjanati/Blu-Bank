//
//  TransfreDetails.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//

import Swinject

class  TransfreDetailsAssembly: Assembly {
    func assemble(container: Container) {
        // ViewModel
        container.register(TransfreDetailsViewController.ViewModel.self) { (_, transfer: TransfreListModel) in
                 return TransfreDetailsViewController.ViewModel(transfer)
             }.inObjectScope(.transient)

        
        // View
        container.register( TransfreDetailsViewController.self) { resolver in
            let vc =  TransfreDetailsViewController()
            vc.coordinator = resolver.resolve( TransfreDetailsCoordinator.self)
            vc.vm = resolver.resolve( TransfreDetailsViewController.ViewModel.self)
            return vc
        }.inObjectScope(.transient)
    }
}
