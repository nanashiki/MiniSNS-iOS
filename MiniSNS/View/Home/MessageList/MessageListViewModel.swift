//
//  MessageListViewModel.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import Foundation
import Combine

class MessageListViewModel: ObservableObject {
    private let messageListReducer: MessageListReducer

    init(apiClient: APIClient, tokenDataStore: TokenDataStore) {
        self.messageListReducer = MessageListReducer(apiClient: apiClient, tokenDataStore: tokenDataStore)
    }

    @MainActor @Published var uiState = MessageListUIState()
    
    @MainActor func update(uiState: MessageListUIState) {
        if self.uiState != uiState {
            self.uiState = uiState
        }
    }
    
    func exec(action: MessageListAction) {
        Task {
            let newUIState = await messageListReducer.reduce(uiState: uiState, action: action)

            await update(uiState: newUIState)
        }
    }
}
