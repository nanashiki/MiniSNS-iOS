//
//  MessageListUIState.swift
//  MessageListUIState
//
//  Created by nanashiki on 2021/09/13.
//

import Foundation

struct MessageListUIState: Equatable {
    enum AlertType: Identifiable, Equatable {
        case apiError(error: Error)
        case confirmLogout
        
        var id: Int {
            switch self {
            case .apiError:
                return 1
            case .confirmLogout:
                return 2
            }
        }
        
        static func == (lhs: MessageListUIState.AlertType, rhs: MessageListUIState.AlertType) -> Bool {
            switch (lhs, rhs) {
            case (.apiError(let error1), .apiError(let error2)):
                return (error1 as NSError) == (error2 as NSError)
            case (.confirmLogout, .confirmLogout):
                return true
            default:
                return false
            }
        }
    }
    
    var messages: [Message] = []
    var isLoading = false
    var alertType: AlertType? = nil
}
