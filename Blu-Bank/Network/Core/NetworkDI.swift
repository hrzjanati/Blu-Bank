//
//  NetworkDI.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//

import Swinject

class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkServiceProtocol.self) { _ in
            NetworkService()
        }
        .inObjectScope(.container)
    }
}
