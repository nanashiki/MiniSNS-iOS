//
//  MessageListWireframe.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/24.
//

import Foundation
import SwiftUI

protocol MessageListWireframe {
    func generateView() -> AnyView
}

struct MessageListRouter: MessageListWireframe {
    func generateView() -> AnyView {
        AnyView(
            MessageListView(
                editPostWireframe: EditPostRouter(),
                viewModel: MessageListViewModel(
                    apiClient: APIClientImpl(),
                    tokenDataStore: TokenDataStoreImpl()
                )
            )
        )
    }
}

#if DEBUG
import Combine

struct MessageListMockRouter: MessageListWireframe {
    func generateView() -> AnyView {
        AnyView(
            MessageListView(
                editPostWireframe: EditPostMockRouter(),
                viewModel: MessageListViewModel(
                    apiClient: APIClientMockForMessageList.shared,
                    tokenDataStore: TokenDataStoreImpl()
                )
            )
        )
    }
}

#endif
