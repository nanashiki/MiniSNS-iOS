//
//  LoginRequest.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import Foundation

struct LoginRequest: Request {
    typealias Response = LoginResponse
    
    typealias RequestBody = LoginRequestBody
    
    let url: URL = URL(string: "https://example.com/login")!
    
    let method: HTTPMethod = .post
    
    let authorization: String? = nil
    
    let requestBody: RequestBody
    
    init(email: String, password: String) {
        requestBody = .init(email: email, password: password)
    }
}

struct LoginRequestBody: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable {
    let token: String
}

#if DEBUG
extension LoginResponse {
    static var mockData: LoginResponse {
        LoginResponse(token: "token")
    }
}
#endif
