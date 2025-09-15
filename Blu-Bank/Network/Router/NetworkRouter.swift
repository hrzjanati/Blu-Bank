//
//  NetworkRouter.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import Foundation

// MARK: - ----------------- Network Configuration
struct NetworkConfig {
#if Development
    static let baseURL = "https://api.example.com/"
#else
    static let baseURL = "https://4e6774cc-4d63-41b2-8003-336545c0a86d.mock.pstmn.io/"
#endif
    
}

// MARK: - ----------------- HTTP Methods
enum RequestMethod: String {
    case get, post, put, patch, delete
}

// MARK: - ----------------- NetworkRouter Protocol
protocol NetworkRouter {
    var path: String { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
    var params: [String: Any]? { get }
    var queryParams: [String: Any]? { get }
    
    func asURLRequest() throws -> URLRequest
}
// MARK: - ----------------- Default Implementation
extension NetworkRouter {
    var headers: [String: String]? { nil }
    var params: [String: Any]? { nil }
    var queryParams: [String: Any]? { nil }
    
    func asURLRequest() throws -> URLRequest {
        var components = URLComponents(string: NetworkConfig.baseURL.appending(path))
        
        if let queryParams = queryParams, !queryParams.isEmpty {
            components?.queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }
        
        guard let url = components?.url else {
            throw NetworkError(description: "Invalid URL", code: 1000)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        if let params = params, [.post, .put, .patch].contains(method) {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
    
}
