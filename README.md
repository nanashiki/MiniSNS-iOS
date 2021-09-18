# MiniSNS-iOS

[iOSDC 2021](https://fortee.jp/iosdc-japan-2021/proposal/72a9c9f1-7440-40a6-84c1-37102909d045) Demo mini SNS app

## Slide

https://speakerdeck.com/nanashiki/iosdc-2021

## Requirements

- swift 5.5 以上
- Xcode 13 以上

## Architecture
![Web 1366 – 14](https://user-images.githubusercontent.com/15953027/133878433-afb4f8ec-4b64-454e-889b-e726f33ad552.png)

- Wireframe: Viewをgenerateするprotocol
- Router: Wireframeのprotocolを適合してViewの実態を返すもの。DIに使用する


## UITest

`/MiniSNSUITests`

- ホームからログアウトして再度ログインするテスト
- メッセージを投稿するテスト
- メッセージにスターをつけるテスト

## Xcode Scheme

- MiniSNS (Mock): MockAPIで起動するSchemeです
- MiniSNS: 実際のサーバと通信するSchemeです。現在は https://example.com との通信になっているので動きません

<img width="184" alt="スクリーンショット 2021-09-18 17 56 02" src="https://user-images.githubusercontent.com/15953027/133883204-76995f33-664a-4b9c-a136-394f9bc95470.png">

