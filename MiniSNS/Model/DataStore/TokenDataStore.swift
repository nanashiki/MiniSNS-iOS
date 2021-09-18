//
//  TokenDataStore.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/24.
//

import Foundation

protocol TokenDataStore {
    func hasToken() -> Bool
    func getToken() -> String?
    func save(token: String)
    func delete()
}


struct TokenDataStoreImpl: TokenDataStore {
    func hasToken() -> Bool {
        getToken() != nil
    }
    
    func getToken() -> String? {
        let query: [String : Any]  = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "Token",
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        switch status {
        case errSecSuccess:
            guard let data = item as? Data else {
                return nil
            }
            return String(data: data, encoding: .utf8)
        default:
            return nil
        }
    }
    
    func save(token: String) {
        guard let dataFromString: Data = token.data(using: .utf8) else {
            return
        }

        delete()
        
        let query: [String : Any] = [
                    kSecClass as String: kSecClassGenericPassword as String,
                    kSecAttrAccount as String: "Token",
                    kSecValueData as String: dataFromString
                ]

        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        print(status)
    }
    
    func delete() {
        let query: [String : Any] = [
                    kSecClass as String: kSecClassGenericPassword as String,
                    kSecAttrAccount as String: "Token"
                ]

        SecItemDelete(query as CFDictionary)
    }
}

#if DEBUG

struct TokenDataStoreMock: TokenDataStore {
    func hasToken() -> Bool {
        true
    }
    
    func getToken() -> String? {
        "token"
    }
    
    func save(token: String) {
    }
    
    func delete() {
    }
}

#endif
