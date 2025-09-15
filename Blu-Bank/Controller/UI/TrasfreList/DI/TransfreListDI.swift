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
         // ViewModel
         container.register(TransfreListViewController.ViewModel.self) { resolver in
             let networkService = resolver.resolve(NetworkServiceProtocol.self)!
             return TransfreListViewController.ViewModel(networkService: networkService)
         }.inObjectScope(.transient)

         // ViewController
         container.register(TransfreListViewController.self) { resolver in
             let vc = TransfreListViewController()
             vc.vm = resolver.resolve(TransfreListViewController.ViewModel.self)
             return vc
         }.inObjectScope(.transient)
     }
}
