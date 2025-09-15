//
//  TransfreDetails.swift
//  Blu-Bank
//
//  Created by Nik on 15/09/2025.
//

import Foundation
// MARK: - ----------------- Network Router
enum TransfreDetailsRouter : NetworkRouter {
    case fetchData

    var path: String {
        switch self {
        case .fetchData:
            return "/sample-endpoint"
        }
    }
    var method: RequestMethod { .get }
}
