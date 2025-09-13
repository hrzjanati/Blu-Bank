//
//  Coordinator.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    func start()
}
