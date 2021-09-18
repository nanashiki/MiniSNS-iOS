//
//  LoginReducer.swift
//  LoginReducer
//
//  Created by nanashiki on 2021/09/13.
//

import Foundation

struct LoginReducer {
    private let apiClient: APIClient
    private let tokenDataStore: TokenDataStore

    init(apiClient: APIClient, tokenDataStore: TokenDataStore) {
        self.apiClient = apiClient
        self.tokenDataStore = tokenDataStore
    }

    func reduce(uiState: LoginUIState, action: LoginAction) async -> LoginUIState {
        var newUiState = uiState
        switch action {
        case .changedEmail:
            newUiState.submitButtonEnable = !uiState.email.isEmpty && !uiState.password.isEmpty
            return newUiState
        case .changedPassword:
            newUiState.submitButtonEnable = !uiState.email.isEmpty && !uiState.password.isEmpty
            return newUiState
        case .login:
            do {
                let response = try await apiClient.send(request: LoginRequest(email: uiState.email, password: uiState.password))
                tokenDataStore.save(token: response.token)

                newUiState.finishLogin = true
                return newUiState
            } catch {
                newUiState.alertType = .apiError(error: error)
                return newUiState
            }
        }
    }
}
