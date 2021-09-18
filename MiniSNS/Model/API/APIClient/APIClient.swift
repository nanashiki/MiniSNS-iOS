//
//  APIClient.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import Foundation
import Combine

enum APIError: Error {
    case statusCode
    case unknown
}

protocol APIClient {
    func send<R: Request>(request: R) async throws -> R.Response
}

struct APIClientImpl: APIClient {
    private let session: URLSession
    private let decoder: JSONDecoder

    public init() {
        session = URLSession.shared
        decoder = JSONDecoder()
    }
    
    public func send<R: Request>(request: R) async throws -> R.Response {
        let urlRequest = request.generateURLRequest()
        
        let (data, response) = try await session.data(for: urlRequest, delegate: nil)
        
        guard let response = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        guard (200..<300).contains(response.statusCode) else {
            throw APIError.statusCode
        }
        
        return try decoder.decode(R.Response.self, from: data)
        
    }
}

#if DEBUG
struct APIClientMock: APIClient {
    private let mockData: [(Any.Type, Any)]
    private let error: Error?

    public init(mockData: [(Any.Type, Any)]) {
        self.mockData = mockData
        self.error = nil
    }

    public init(error: Error) {
        self.mockData = []
        self.error = error
    }

    public func send<R: Request>(request: R) async throws -> R.Response {
        if let error = self.error {
            throw error
        }

        return self.mockData.first { (key, value) in
            R.self == key &&  value is R.Response
        }
        .map {
            $0.1 as! R.Response
        }!
    }
}
#endif
