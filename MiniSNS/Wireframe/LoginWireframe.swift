//
//  LoginWireframe.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import Foundation
import SwiftUI

protocol LoginWireframe {
    func generateView() -> AnyView
}

struct LoginRouter: LoginWireframe {
    func generateView() -> AnyView {
        AnyView(
            LoginView(
                viewModel: LoginViewModel(apiClient: APIClientImpl(), tokenDataStore: TokenDataStoreImpl())
            )
        )
    }
}

#if DEBUG
struct LoginMockRouter: LoginWireframe {
    func generateView() -> AnyView {
        AnyView(
            LoginView(
                viewModel: LoginViewModel(
                    apiClient: APIClientMock(mockData: [
                        (LoginRequest.self, LoginResponse(token: "token"))
                    ]),
                    tokenDataStore: TokenDataStoreMock()
                )
            )
        )
    }
}
#endif
