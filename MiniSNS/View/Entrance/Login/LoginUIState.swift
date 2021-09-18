//
//  LoginUIState.swift
//  LoginUIState
//
//  Created by nanashiki on 2021/09/13.
//

import Foundation

struct LoginUIState: Equatable {
    enum AlertType: Identifiable, Equatable {
        case apiError(error: Error)
        
        var id: Int {
            switch self {
            case .apiError:
                return 1
            }
        }
        
        static func == (lhs: LoginUIState.AlertType, rhs: LoginUIState.AlertType) -> Bool {
            switch (lhs, rhs) {
            case (.apiError(let error1), .apiError(let error2)):
                return (error1 as NSError) == (error2 as NSError)
            }
        }
    }
    
    var email = ""
    var password = ""
    var alertType: AlertType? = nil
    var submitButtonEnable = false
    var finishLogin = false
}
