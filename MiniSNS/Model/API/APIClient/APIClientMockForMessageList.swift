//
//  APIClientMockForMessageList.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/09/18.
//

import Foundation

#if DEBUG
class APIClientMockForMessageList: APIClient {
    static let shared = APIClientMockForMessageList()
    
    private init() {}
    
    var mockData = [
        MessageListResponse(id: "id1", text: "Hello!", userName: "nanashiki1", isFavorite: true),
        MessageListResponse(id: "id2", text: "iOSDC!", userName: "nanashiki2", isFavorite: false),
        MessageListResponse(id: "id3", text: "2021!", userName: "nanashiki3", isFavorite: true),
    ]
    
    func send<R: Request>(request: R) async throws -> R.Response {
        if request is MessageListRequest {
            return self.mockData as! R.Response
        } else if let messageSendRequest = request as? MessageSendRequest {
            let newMessage = MessageListResponse(id: UUID().uuidString, text: messageSendRequest.requestBody.text, userName: "名無し", isFavorite: false)
            self.mockData += [
                newMessage
            ]
            return MessageSendResponse(id: newMessage.id) as! R.Response
        } else if let messageStarRequest = request as? MessageStarRequest {
            self.mockData = self.mockData.map {
                if $0.id == messageStarRequest.requestBody.messageId {
                    return MessageListResponse(id: $0.id, text: $0.text, userName: $0.userName, isFavorite: messageStarRequest.requestBody.isStar)
                } else {
                    return $0
                }
            }
            return MessageStarResponse(id: messageStarRequest.requestBody.messageId) as! R.Response
        } else {
            throw APIError.unknown
        }
    }
}
#endif
