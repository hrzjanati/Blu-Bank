//
//  AppDI.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import Swinject

class AppDIContainer {
    // MARK: - ----------------- Properties
    static let shared = AppDIContainer()
    let container = Container()
    // MARK: - ----------------- Init
    private init() {
        let assemblies: [Assembly] = [
            NetworkAssembly(),
            TransfreListAssembly(),
            TransfreDetailsAssembly()
            
        ]
        assemblies.forEach { $0.assemble(container: container) }
    }
}
