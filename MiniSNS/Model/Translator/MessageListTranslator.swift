//
//  MessageListTranslator.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/25.
//

import Foundation

struct MessageListTranslator {
    static func translate(response: [MessageListResponse]) -> [Message] {
        response.map {
            Message(id: $0.id, text: $0.text, userName: $0.userName, isFavorite: $0.isFavorite)
        }
    }
}
