//
//  BaseRemoteDataSource.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import Foundation

// MARK: - Base Networking Layer
// Shared networking utilities for all features

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingFailed
    case serverError(statusCode: Int)
    case noConnection
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .noData: return "No data received"
        case .decodingFailed: return "Failed to decode response"
        case .serverError(let code): return "Server error: \(code)"
        case .noConnection: return "No internet connection"
        }
    }
}

// MARK: - Base API Client (extend per feature)
class BaseAPIClient {
    
    let session: URLSession
    let baseURL: String
    
    init(baseURL: String = "", session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func request<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Data? = nil
    ) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noData
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
