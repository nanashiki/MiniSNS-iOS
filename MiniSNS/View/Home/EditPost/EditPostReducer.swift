//
//  EditPostReducer.swift
//  EditPostReducer
//
//  Created by nanashiki on 2021/09/13.
//

import Foundation

struct EditPostReducer {
    private let apiClient: APIClient
    private let tokenDataStore: TokenDataStore

    init(apiClient: APIClient, tokenDataStore: TokenDataStore) {
        self.apiClient = apiClient
        self.tokenDataStore = tokenDataStore
    }
    
    func reduce(uiState: EditPostUIState, action: EditPostAction) async -> EditPostUIState {
        var newUiState = uiState
        switch action {
        case .send:
            do {
                try await send(text: uiState.text)
                newUiState.text = ""
            } catch {
                
            }
            return newUiState
        }
    }
    
    private func send(text: String) async throws  {
        _ = try await apiClient.send(request: MessageSendRequest(text: text,authorization: tokenDataStore.getToken() ?? ""))
    }
}
