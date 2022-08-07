//
//  Model.swift
//  TwitterSampleApp
//
//  Created by 後藤勇 on 2022/07/31.
//

import Foundation
import RealmSwift


// ツイートデータのモデルを設定。realmを使うときは以下が必要
// classであること
// Object型であること
// プロパティの定義に「@objc dynamic」キーワードがついていること
class TweetDataModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var userName: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var tweet: String = ""
    
    // オーバーライドし、プライマリキーにしたい変数名を返すメソッド
    override static func primaryKey() -> String? {
        return "id"
    }
}

