//
//  TokenDataStoreImplTeests.swift
//  MiniSNSUnitTests
//
//  Created by nanashiki on 2021/08/24.
//

import XCTest

@testable import MiniSNS

class TokenDataStoreImplTeests: XCTestCase {
    func testSaveAndGetAndDeleteToken() {
        let impl = TokenDataStoreImpl()
        
        impl.save(token: "token")
        
        let gotToken = impl.getToken()
        
        XCTAssertEqual(gotToken, "token")
        
        impl.delete()
        
        let gotToken2 = impl.getToken()
        
        XCTAssertEqual(gotToken2, nil)
    }
}
