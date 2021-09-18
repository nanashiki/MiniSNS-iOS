//
//  MessageListReducerTests.swift
//  MiniSNSUnitTests
//
//  Created by nanashiki on 2021/09/18.
//

import Foundation
import XCTest

@testable import MiniSNS

class MessageListReducerTests: XCTestCase {
    func testStartLoading() async {
        let reducer = MessageListReducer(apiClient: APIClientMock(mockData: []), tokenDataStore: TokenDataStoreMock())
        
        let newState = await reducer.reduce(
            uiState: MessageListUIState(isLoading: false),
            action: .startLoading
        )
        
        XCTAssertEqual(newState, MessageListUIState(isLoading: true))
    }
    
    func testRefresh() async {
        let reducer = MessageListReducer(apiClient: APIClientMock(mockData: [
            (
                MessageListRequest.self,
                MessageListResponse.mockData
            )
        ]), tokenDataStore: TokenDataStoreMock())
        
        let newState = await reducer.reduce(
            uiState: MessageListUIState(isLoading: true),
            action: .refresh
        )
        
        XCTAssertEqual(
            newState,
            MessageListUIState(
                messages: [
                    Message(id: "id1", text: "Hello!", userName: "nanashiki1", isFavorite: true),
                    Message(id: "id2", text: "iOSDC!", userName: "nanashiki2", isFavorite: false),
                    Message(id: "id3", text: "2021!", userName: "nanashiki3", isFavorite: true),
                ],
                isLoading: false
            )
        )
    }
    
    func testChangeStar() async {
        let reducer = MessageListReducer(apiClient: APIClientMockForMessageList.shared, tokenDataStore: TokenDataStoreMock())
        
        let newState = await reducer.reduce(
            uiState: MessageListUIState(),
            action: .changeStar(messageId: "id2", isStar: true)
        )
        
        XCTAssertEqual(
            newState,
            MessageListUIState(
                messages: [
                    Message(id: "id1", text: "Hello!", userName: "nanashiki1", isFavorite: true),
                    Message(id: "id2", text: "iOSDC!", userName: "nanashiki2", isFavorite: true),
                    Message(id: "id3", text: "2021!", userName: "nanashiki3", isFavorite: true),
                ],
                isLoading: false
            )
        )
    }
    
    func testConfirmLogout() async {
        let reducer = MessageListReducer(apiClient: APIClientMock(mockData: []), tokenDataStore: TokenDataStoreMock())
        
        let newState = await reducer.reduce(
            uiState: MessageListUIState(),
            action: .confirmLogout
        )
        
        XCTAssertEqual(
            newState,
            MessageListUIState(alertType: .confirmLogout)
        )
    }
    
    func testLogout() async {
        let reducer = MessageListReducer(apiClient: APIClientMock(mockData: []), tokenDataStore: TokenDataStoreMock())
        
        let newState = await reducer.reduce(
            uiState: MessageListUIState(),
            action: .logout
        )
        
        XCTAssertEqual(
            newState,
            MessageListUIState()
        )
    }
}
