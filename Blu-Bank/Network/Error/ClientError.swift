//
//  ClientError.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import Foundation
//MARK: - Customize Errors
enum ClientError: Int, Error {
    typealias RawValue = Int
    case unreachable = 1000
    case timeOut = 504
    case unprocessable = 422
    case internalServer = 500
    case parser = 1001
    case unknown = 1002
    case noContent = 204
    case notFound = 404
    case unauthorized = 401
    case badRequest = 400
    case forbidden = 403
    case methodNotAllowed = 405
    case conflict = 409
    case tooManyRequests = 429
    case legalReasons = 451
    case badGateway = 502
    case invalidRequest = 509
    case noNetwork = 1009
}
//MARK: - Set Description For Erros
extension ClientError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unreachable:
            return "Network/error_network_unreachable_message"
        case .timeOut, .internalServer:
            return "Network/error_server_unreachable_message"
        case .unprocessable:
            return "Network/unprocceessable entity"
        case .parser:
            return "Network/Parser error."
        case .unknown:
            return "Network/Unknown error."
        case .noContent:
            return "Network/No Content"
        case .notFound:
            return "Network/Not found"
        case .unauthorized:
            return "Network/Unauthorized Access"
        case .badRequest:
            return "Network/Invalid Request Parameters"
        case .forbidden:
            return "Network/Forbidden Access"
        case .methodNotAllowed:
            return "Network/Method Not Allowed"
        case .conflict:
            return "Network/Conflict"
        case .tooManyRequests:
            return "Network/Too many requests"
        case .legalReasons:
            return "Network/Deny access in order to Legal reasons"
        case .badGateway:
            return "Network/Bad gateway"
        case .invalidRequest:
            return "Network/Invalid Request parameters"
        case .noNetwork:
            return "Network/You are not connected to the internet"
        }
    }
}
