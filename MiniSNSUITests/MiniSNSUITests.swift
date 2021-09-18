//
//  MiniSNSUITests.swift
//  MiniSNSUITests
//
//  Created by nanashiki on 2021/08/24.
//

import XCTest

class MiniSNSUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments = ["-MockAPI"]
        app.launch()
    }

    // ホームからログアウトして再度ログインするテスト
    func testLogoutAndLogin() throws {
        let app = XCUIApplication()

        // Home画面のNavigationBarのログアウトをtap
        app.navigationBars.firstMatch.buttons["Logout"].tap()
        
        // 確認Alertの表示をチェック
        XCTAssert(app.alerts["確認"].exists)
        
        // 確認Alertのログアウトをタップ
        app.alerts["確認"].buttons["ログアウト"].tap()
        
        // Entrance画面のLoginをtap
        app.buttons["Login"].tap()
        
        
        app.textFields["e-mail"].tap()
        app.typeText("test@example.com")
        
        app.secureTextFields["Password"].tap()
        app.typeText("hogehoge")
        
        // Keyboardを閉じる
        app.buttons["return"].tap()

        app.buttons["Submit"].tap()

        // Home画面に来たことを確認
        XCTAssert(app.navigationBars["TimeLine"].exists)
    }

    // メッセージを投稿するテスト
    func testMessagePost() throws {
        let app = XCUIApplication()

        // 投稿フィールドをタップ
        app.textFields["Post"].tap()
        
        // キーボードが出るまで待つ
        sleep(1)
        
        // 投稿する文字を入力
        app.typeText("test")
        
        // 送信ボタンををタップ
        app.buttons["Send"].tap()
        
        // 投稿が反映されるまで待つ
        sleep(1)
        
        // 投稿が一覧に表示されていることを確認
        XCTAssert(app.tables.staticTexts["test"].exists)
    }

    /// メッセージにスターをつけるテスト
    func testMessageStar() throws {
        let app = XCUIApplication()

        // スターがついてないことを確認
        XCTAssert(app.tables.cells["nanashiki2, Favorite, iOSDC!"].buttons["message_star"].exists)

        // スターをタップ
        app.tables.cells["nanashiki2, Favorite, iOSDC!"].buttons.element(boundBy: 0).tap()

        // スターがついていることを確認
        XCTAssert(app.tables.cells["nanashiki2, Favorite, iOSDC!"].buttons["message_star_active"].exists)

        // スターをタップ
        app.tables.cells["nanashiki2, Favorite, iOSDC!"].buttons.element(boundBy: 0).tap()

        // スターがついてないことを確認
        XCTAssert(app.tables.cells["nanashiki2, Favorite, iOSDC!"].buttons["message_star"].exists)
    }
}
