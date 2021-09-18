//
//  Request.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Request {
    associatedtype Response: Decodable
    associatedtype RequestBody: Encodable

    var url: URL { get }

    var method: HTTPMethod { get }

    var authorization: String? { get }
    
    var requestBody: RequestBody { get }
}

extension Request {
    func generateURLRequest() -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = [:]

        if method != .get {
            request.httpBody = try? JSONEncoder().encode(requestBody)
        }

        return request
    }
}
