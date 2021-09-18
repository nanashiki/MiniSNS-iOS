//
//  EditPostView.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/09/06.
//

import SwiftUI

struct EditPostView: View {
    @StateObject var viewModel: EditPostViewModel
    let postedAction: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Divider()
            HStack {
                TextField("Post", text: $viewModel.uiState.text)
                    .frame(height: 44)
                    .background(Color.white.edgesIgnoringSafeArea(.bottom))
                    .padding(.leading, 16)
                Button {
                    viewModel.exec(action: .send)
                    postedAction()
                } label: {
                    Text("Send")
                }
                .padding(.trailing, 16)
            }
            
        }
    }
}

struct EditPostView_Previews: PreviewProvider {
    static var previews: some View {
        EditPostView(
            viewModel: EditPostViewModel(
                apiClient: APIClientMockForMessageList.shared,
                tokenDataStore: TokenDataStoreMock()
            ),
            postedAction: {}
        )
    }
}
