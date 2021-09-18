//
//  MessageListAction.swift
//  MessageListAction
//
//  Created by nanashiki on 2021/09/13.
//

import Foundation

enum MessageListAction {
    case startLoading
    case refresh
    case changeStar(messageId: String, isStar: Bool)
    case confirmLogout
    case logout
}
