//
//  HomeRouter.swift
//  Blu-Bank
//
//  Created by Nik on 13/09/2025.
//

import Foundation

// MARK: - Transfer Router Example
enum TransferRouter: NetworkRouter {
    case transferList(page: Int)
    
    var path: String { "transfer-list/" }
    var method: RequestMethod { .get }
    var queryParams: [String : Any]? {
        switch self {
        case .transferList(let page):
            return ["page": page]
        }
    }
}
