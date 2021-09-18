//
//  MessageListReducer.swift
//  MessageListReducer
//
//  Created by nanashiki on 2021/09/13.
//

import Foundation

struct MessageListReducer {
    private let apiClient: APIClient
    private let tokenDataStore: TokenDataStore

    init(apiClient: APIClient, tokenDataStore: TokenDataStore) {
        self.apiClient = apiClient
        self.tokenDataStore = tokenDataStore
    }
    
    func reduce(uiState: MessageListUIState, action: MessageListAction) async -> MessageListUIState {
        var newUiState = uiState
        switch action {
        case .startLoading:
            newUiState.isLoading = true
            return newUiState
        case .refresh:
            do {
                let messages = try await fetch()
                newUiState.isLoading = false
                newUiState.messages = messages
                return newUiState
            } catch  {
                newUiState.isLoading = false
                newUiState.alertType = .apiError(error: error)
                return newUiState
            }
        case let .changeStar(messageId, isStar):
            do {
                let messages = try await changeStar(messageId: messageId, isStar: isStar)
                newUiState.messages = messages
                return newUiState
            } catch  {
                newUiState.alertType = .apiError(error: error)
                return newUiState
            }
        case .confirmLogout:
            newUiState.alertType = .confirmLogout
            return newUiState
        case .logout:
            tokenDataStore.delete()
            return newUiState
        }
    }
    
    private func fetch() async throws -> [Message] {
        let response = try await apiClient.send(request: MessageListRequest(authorization: tokenDataStore.getToken() ?? ""))
        
        return MessageListTranslator.translate(response: response)
    }
    
    private func changeStar(messageId: String, isStar: Bool) async throws -> [Message] {
        _ = try await apiClient.send(request: MessageStarRequest(messageId: messageId, isStar: isStar, authorization: tokenDataStore.getToken() ?? ""))

        return try await fetch()
    }
}
