//
//  EditPostViewModel.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/09/06.
//

import Foundation

class EditPostViewModel: ObservableObject {
    private let editPostReducer: EditPostReducer

    init(apiClient: APIClient, tokenDataStore: TokenDataStore) {
        self.editPostReducer = EditPostReducer(apiClient: apiClient, tokenDataStore: tokenDataStore)
    }

    @MainActor @Published var uiState = EditPostUIState()
    
    @MainActor func update(uiState: EditPostUIState) {
        if self.uiState != uiState {
            self.uiState = uiState
        }
    }
    
    func exec(action: EditPostAction) {
        Task {
            let newUIState = await editPostReducer.reduce(uiState: uiState, action: action)

            await update(uiState: newUIState)
        }
    }
}
