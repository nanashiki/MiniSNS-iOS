//
//  LoginView.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.blue)
                Text("Login")
                    .font(.title.bold())
                    .foregroundColor(.white)
            }
            .edgesIgnoringSafeArea(.vertical)
            .frame(height: 296)

            TextField("e-mail", text: $viewModel.uiState.email)
                .font(.body)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))

            Divider()
                .padding(.horizontal)

            SecureField("Password", text: $viewModel.uiState.password)
                .font(.body)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))

            Divider()
                .padding(.horizontal)

            Button {
                viewModel.exec(action: .login)
            } label: {
                Text("Submit")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.uiState.submitButtonEnable ? Color.blue.cornerRadius(6.0) : Color.gray.cornerRadius(6.0))
                    .foregroundColor(.white)
            }
            .disabled(!viewModel.uiState.submitButtonEnable)
            .padding()
            
            Spacer()
        }
        .onReceive(viewModel.$uiState) { uiState in
            if uiState.finishLogin {
                NotificationCenter.default.post(
                    name: NotificationName.finishLogin,
                    object: nil
                )
            }
        }
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            viewModel: LoginViewModel(
                apiClient: APIClientMock(
                    mockData: [
                        (LoginResponse.self, LoginResponse.mockData)
                    ]
                ),
                tokenDataStore: TokenDataStoreMock()
            )
        )
    }
}
#endif
