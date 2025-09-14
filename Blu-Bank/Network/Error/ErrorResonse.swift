//
//  ErrorResonse.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import Foundation
// MARK: - General ErrorResponse
struct ErrorResponse: Codable {
    let statusCode: Int?
    let message: String?
    let details: [String: String]?
    
    enum CodingKeys: String, CodingKey {
        case statusCode, message, details
    }
}
