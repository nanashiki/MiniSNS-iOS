//
//  MiniSNSApp.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import SwiftUI

enum WindowType {
    case entrance
    case home
}

@main
struct MiniSNSApp: App {
    @State private  var type: WindowType =  MiniSNSApp.isLoggedIn() ? .home : .entrance

    var body: some Scene {
        WindowGroup {
            switch type {
            case .entrance:
                EntranceView(loginWireframe: generateLoginRouter())
                    .onReceive(NotificationCenter.default.publisher(for: NotificationName.finishLogin)){ _ in
                        type = .home
                    }
            case .home:
                generateMessageListRouter().generateView()
                    .onReceive(NotificationCenter.default.publisher(for: NotificationName.logout)){ _ in
                        type = .entrance
                    }
            }
        }
    }

    private func generateLoginRouter() -> LoginWireframe {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-MockAPI") {
            return LoginMockRouter()
        }
        #endif

        return LoginRouter()
    }
    
    private func generateMessageListRouter() -> MessageListWireframe {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-MockAPI") {
            return MessageListMockRouter()
        }
        #endif

        return MessageListRouter()
    }
    
    private static func isLoggedIn() -> Bool {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-MockAPI") {
            return TokenDataStoreMock().hasToken()
        }
        #endif

        return TokenDataStoreImpl().hasToken()
    }
}

enum NotificationName {
    static let finishLogin = Notification.Name("finishLogin")
    static let logout = Notification.Name("logout")
}
