//
//  EditPostWireframe.swift
//  EditPostWireframe
//
//  Created by nanashiki on 2021/09/13.
//

import Foundation
import SwiftUI

protocol EditPostWireframe {
    func generateView(postedAction: @escaping () -> Void) -> AnyView
}

struct EditPostRouter: EditPostWireframe {
    func generateView(postedAction: @escaping () -> Void) -> AnyView {
        AnyView(
            EditPostView(
                viewModel: EditPostViewModel(
                    apiClient: APIClientImpl(),
                    tokenDataStore: TokenDataStoreImpl()
                ),
                postedAction: { postedAction() }
            )
        )
    }
}

#if DEBUG
import Combine

struct EditPostMockRouter: EditPostWireframe {
    func generateView(postedAction: @escaping () -> Void) -> AnyView {
        AnyView(
            EditPostView(
                viewModel: EditPostViewModel(
                    apiClient: APIClientMockForMessageList.shared,
                    tokenDataStore: TokenDataStoreImpl()
                ),
                postedAction: { postedAction() }
            )
        )
    }
}
#endif
