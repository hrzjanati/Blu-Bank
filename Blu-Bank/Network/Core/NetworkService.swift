//
//  NetworkService.swift
//  Blu-Bank
//
//  Created by Nik on 14/09/2025.
//

import Foundation
import Combine
// MARK: - ----------------- Protocol NetworkService
protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: NetworkRouter) -> AnyPublisher<T, NetworkError>
}
// MARK: - ----------------- Network Service
final class NetworkService {
    // MARK: - ----------------- Propeties
    private let decoder: JSONDecoder
    // MARK: - ----------------- Init
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
}
// MARK: - ----------------- NetworkServiceProtocol
extension NetworkService : NetworkServiceProtocol {
    /// Request
    func request<T: Decodable>(_ router: NetworkRouter) -> AnyPublisher<T, NetworkError> {
        let urlString = NetworkConfig.baseURL + router.path
        guard var components = URLComponents(string: urlString) else {
            return Fail(error: NetworkError(description: "Invalid URL", code: 1000)).eraseToAnyPublisher()
        }
        
        if let queryParams = router.queryParams, !queryParams.isEmpty {
            components.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = components.url else {
            return Fail(error: NetworkError(description: "Invalid URL", code: 1000)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = router.method.rawValue.uppercased()
        
        router.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        if let params = router.params, [.post, .put, .patch].contains(router.method) {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse,
                      200..<300 ~= response.statusCode else {
                    throw NetworkError(description: "Server error", code: (result.response as? HTTPURLResponse)?.statusCode ?? 1001)
                }
                return result.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                NetworkError(description: error.localizedDescription, code: (error as NSError).code)
            }
            .eraseToAnyPublisher()
    }
}
