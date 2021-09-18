//
//  LoginReducerTests.swift
//  LoginReducerTests
//
//  Created by nanashiki on 2021/09/13.
//

import Foundation
import XCTest

@testable import MiniSNS

class LoginViewModelTests: XCTestCase {
    func testChangedValidEmail() async {
        let reducer = LoginReducer(apiClient: APIClientMock(mockData: []), tokenDataStore: TokenDataStoreMock())
        
        let newState = await reducer.reduce(uiState: LoginUIState(email: "email", password: "passeord", submitButtonEnable: false), action: .changedEmail)
        
        XCTAssertEqual(newState, LoginUIState(email: "email", password: "passeord", submitButtonEnable: true))
    }
    
    func testChangedInvalidEmail() async {
        let reducer = LoginReducer(apiClient: APIClientMock(mockData: []), tokenDataStore: TokenDataStoreMock())
        
        let newState = await reducer.reduce(uiState: LoginUIState(email: "", password: "passeord", submitButtonEnable: false), action: .changedEmail)
        
        XCTAssertEqual(newState, LoginUIState(email: "", password: "passeord", submitButtonEnable: false))
    }
    
    func testChangedValidPassword() async {
        let reducer = LoginReducer(apiClient: APIClientMock(mockData: []), tokenDataStore: TokenDataStoreMock())
        
        let newState = await reducer.reduce(uiState: LoginUIState(email: "email", password: "passeord", submitButtonEnable: false), action: .changedPassword)
        
        XCTAssertEqual(newState, LoginUIState(email: "email", password: "passeord", submitButtonEnable: true))
    }
    
    func testChangedInvalidPassword() async {
        let reducer = LoginReducer(apiClient: APIClientMock(mockData: []), tokenDataStore: TokenDataStoreMock())
        
        let newState = await reducer.reduce(uiState: LoginUIState(email: "email", password: "", submitButtonEnable: false), action: .changedPassword)
        
        XCTAssertEqual(newState, LoginUIState(email: "email", password: "", submitButtonEnable: false))
    }
    
    func testLoginSuccess() async {
        let reducer = LoginReducer(apiClient: APIClientMock(mockData: [
            (
                LoginRequest.self,
                LoginResponse(token: "token")
            )
        ]), tokenDataStore: TokenDataStoreMock())
        
        let newState = await reducer.reduce(uiState: LoginUIState(finishLogin: false), action: .login)
        
        XCTAssertEqual(newState, LoginUIState(finishLogin: true))
    }
    
    func testLoginError() async {
        let reducer = LoginReducer(apiClient: APIClientMock(error: APIClientMockError.default), tokenDataStore: TokenDataStoreMock())
        
        let newState = await reducer.reduce(uiState: LoginUIState(finishLogin: false), action: .login)
        
        XCTAssertEqual(newState, LoginUIState(alertType: .apiError(error: APIClientMockError.default) ,finishLogin: false))
    }
}
