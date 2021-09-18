//
//  MessageListRequest.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import Foundation

struct MessageListRequest: Request {
    typealias Response = [MessageListResponse]
    
    typealias RequestBody = LoginRequestBody //TODO:
    
    let url: URL = URL(string: "https://example.com/messages")!
    
    let method: HTTPMethod = .get
    
    let authorization: String?
    
    let requestBody: RequestBody = LoginRequestBody(email: "", password: "") //TODO:
    
    init(authorization: String) {
        self.authorization = authorization
    }
}

struct MessageListResponse: Decodable {
    let id: String
    let text: String
    let userName: String
    let isFavorite: Bool
}

#if DEBUG
extension MessageListResponse {
    static var mockData: [MessageListResponse] {
        [
            MessageListResponse(id: "id1", text: "Hello!", userName: "nanashiki1", isFavorite: true),
            MessageListResponse(id: "id2", text: "iOSDC!", userName: "nanashiki2", isFavorite: false),
            MessageListResponse(id: "id3", text: "2021!", userName: "nanashiki3", isFavorite: true),
            
        ]
    }
}
#endif
