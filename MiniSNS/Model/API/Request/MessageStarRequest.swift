//
//  MessageStarRequest.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/24.
//

import Foundation

struct MessageStarRequest: Request {
    typealias Response = MessageStarResponse
    
    typealias RequestBody = MessageStarRequestBody
    
    let url: URL = URL(string: "https://example.com/messageStars")!
    
    let method: HTTPMethod = .post
    
    let authorization: String?
    
    let requestBody: RequestBody
    
    init(messageId: String, isStar: Bool, authorization: String) {
        requestBody = MessageStarRequestBody(messageId: messageId, isStar: isStar)
        self.authorization = authorization
    }
}

struct MessageStarRequestBody: Encodable {
    let messageId: String
    let isStar: Bool
}

struct MessageStarResponse: Decodable {
    let id: String
}
