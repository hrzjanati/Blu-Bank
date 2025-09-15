//
//  NetworkError.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import Foundation

struct NetworkError: LocalizedError {
    var code: Int
    var errorObject: ErrorResponse?
    private var _description: String
    
    var errorDescription: String? { "[\(code)] \(_description)" }
    
    init(description: String, code: Int) {
        self._description = description
        self.code = code
    }
    
    init(clientError: ClientError) {
        self._description = clientError.errorDescription ?? "Unknown Error"
        self.code = clientError.rawValue
    }
    
    init(errorModel: ErrorResponse) {
        self.errorObject = errorModel
        self._description = errorModel.message ?? "Unknown Error"
        self.code = errorModel.statusCode ?? 1001
    }
}
