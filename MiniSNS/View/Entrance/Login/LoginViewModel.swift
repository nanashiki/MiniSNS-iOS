//
//  LoginViewModel.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    private let loginReducer: LoginReducer

    init(apiClient: APIClient, tokenDataStore: TokenDataStore) {
        self.loginReducer = LoginReducer(apiClient: apiClient, tokenDataStore: tokenDataStore)
    }
    
    @MainActor @Published var uiState = LoginUIState() {
        didSet {
            if oldValue.email != uiState.email {
                exec(action: .changedEmail)
            }
            
            if oldValue.password != uiState.password {
                exec(action: .changedPassword)
            }
        }
    }
    
    @MainActor func update(uiState: LoginUIState) {
        if self.uiState != uiState {
            self.uiState = uiState
        }
    }
    
    func exec(action: LoginAction) {
        Task {
            let newUIState = await loginReducer.reduce(uiState: uiState, action: action)
            
            await update(uiState: newUIState)
        }
    }
}
