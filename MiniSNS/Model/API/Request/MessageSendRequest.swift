//
//  MessageSendRequest.swift
//  MessageSendRequest
//
//  Created by nanashiki on 2021/09/13.
//

import Foundation

struct MessageSendRequest: Request {
    typealias Response = MessageSendResponse
    
    typealias RequestBody = MessageSendRequestBody
    
    let url: URL = URL(string: "https://example.com/messages")!
    
    let method: HTTPMethod = .post
    
    let authorization: String?
    
    let requestBody: RequestBody
    
    init(text: String, authorization: String) {
        requestBody = MessageSendRequestBody(text: text)
        self.authorization = authorization
    }
}

struct MessageSendRequestBody: Encodable {
    let text: String
}

struct MessageSendResponse: Decodable {
    let id: String
}
