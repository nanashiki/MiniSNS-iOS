//
//  MessageListView.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import SwiftUI

struct MessageListView: View {
    let editPostWireframe: EditPostWireframe
    @StateObject var viewModel: MessageListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.uiState.messages) { message in
                MessageRowView(message: message) { isStar in
                    viewModel.exec(action: .changeStar(messageId: message.id, isStar: isStar))
                }
            }
            .listStyle(PlainListStyle())
            .overlay(
                editPostWireframe.generateView {
                    viewModel.exec(action: .startLoading)
                    viewModel.exec(action: .refresh)
                }
            )
            .navigationTitle("TimeLine")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.exec(action: .confirmLogout)
                    } label: {
                        Text("Logout")
                    }
                }
            }
        }
        .alert(item: $viewModel.uiState.alertType) {
            switch $0 {
            case let .apiError(error):
                return Alert(
                    title: Text("エラー"),
                    message: Text(error.localizedDescription),
                    dismissButton: nil
                )
            case .confirmLogout:
                return Alert(
                    title: Text("確認"),
                    message: Text("ログアウトしますか？"),
                    primaryButton: Alert.Button.destructive(Text("ログアウト")) {
                        viewModel.exec(action: .logout)
                        NotificationCenter.default.post(name: NotificationName.logout, object: nil)
                    },
                    secondaryButton: Alert.Button.cancel()
                )
            }
        }
        .refreshable {
            viewModel.exec(action: .startLoading)
            viewModel.exec(action: .refresh)
        }
        .onAppear {
            viewModel.exec(action: .startLoading)
            viewModel.exec(action: .refresh)
        }
    }
}

#if DEBUG

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView(
            editPostWireframe: EditPostMockRouter(),
            viewModel: MessageListViewModel(
                apiClient: APIClientMockForMessageList.shared,
                tokenDataStore: TokenDataStoreMock()
            )
        )
    }
}

#endif
