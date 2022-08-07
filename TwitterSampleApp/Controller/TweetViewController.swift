//
//  TweetViewController.swift
//  TwitterSampleApp
//
//  Created by 後藤勇 on 2022/08/01.
//

import UIKit
import RealmSwift


class TweetViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var userNameView: UITextView!
    @IBOutlet weak var tweetView: UITextView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var placeholderOfUserNameView: UILabel!
    @IBOutlet weak var placeholderOfTweetView: UILabel!
    
    // キャンセルボタンを押したときの処理
    @IBAction func cancelButton(_ sender: UIButton) {
        // なにもせずに前のホーム画面に戻る
        navigationController?.popViewController(animated: true)
    }
    
    // ツイート（編集）ボタンを押したときの処理
    @IBAction func tweetButtonAction(_ sender: UIButton) {
        // ツイート文字数が140を超えていたら何もしない
        guard tweetView.text.count <= 140 else {
            return
        }
        // 現在の入力内容をrealmに保存するメソッドを呼び出す
        let updateUserName = userNameView.text ?? ""
        let updateTweet = tweetView.text ?? ""
        saveData(currentUserName: updateUserName, currentTweet: updateTweet)
        // ホーム画面に戻る
        navigationController?.popViewController(animated: true)
    }
    
    // 日付型を文字列型に変換する処理
    var dateFormatter: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ja_JP")
        dateFormat.timeZone = .current
        dateFormat.dateStyle = .long
        dateFormat.timeStyle = .short
        return dateFormat
    }

    // ツイートデータモデルをインスタンス化
    var tweetData = TweetDataModel()
    
    // ツイート画面を最初に読み込んだときの処理
    override func viewDidLoad() {
        super.viewDidLoad()
        // tweetView,userNameViewともにデリゲートへ自身を定義
        tweetView.delegate = self
        userNameView.delegate = self
        // ツイート画面にユーザー名とツイートを表示するメソッドを呼び出す
        displayTweet()
        // テキストビュー（ユーザー名とツイート）が更新された（変化した）ときの処理を呼び出す
        UserNameViewDidChange()
        tweetViewDidChange()
        // tweetViewの文字数が140文字以下か検証するメソッドを呼び出す
        let isLessThanOrEqual = validation(tweet: tweetView.text)
        // tweetViewの文字数をtextCountLabelに表示し、140文字をしきい値にして文字の色を変更するメソッドを呼び出す
        displayTextCountLabel(tweetable: isLessThanOrEqual)
        
        if tweetData.userName == "" && tweetData.tweet == "" && tweetData.date == "" {
            tweetButton.setTitle("ツイートする", for: .normal)
        }
    }
    
    // テキストビュー（ユーザー名とツイート）が更新された（変化した）ときの処理
    func textViewDidChange(_ textView: UITextView) {
        // ユーザー名とツイートのプレースホルダを表示/非表示するメソッドを呼び出す
        UserNameViewDidChange()
        tweetViewDidChange()
        // tweetViewの文字数が140文字以下か検証するメソッドを呼び出す
        let isLessThanOrEqual = validation(tweet: tweetView.text)
        // tweetViewの文字数をtextCountLabelに表示し、140文字をしきい値にして文字の色を変更するメソッドを呼び出す
        displayTextCountLabel(tweetable: isLessThanOrEqual)
    }
    
    // テーブルビューセルからツイート画面に遷移したときのみ行われる処理
    func configure(tweet: TweetDataModel) {
        tweetData.id = tweet.id
        tweetData.userName = tweet.userName
        tweetData.date = tweet.date
        tweetData.tweet = tweet.tweet
    }
    
    // ツイート画面にユーザー名とツイートを表示するメソッド
    func displayTweet() {
        userNameView.text = tweetData.userName
        tweetView.text = tweetData.tweet
    }
    
    // ユーザー名プレースホルダを表示/非表示するメソッド
    func UserNameViewDidChange() {
        if userNameView.text.count == 0 {
            placeholderOfUserNameView.isHidden = false
        } else {
            placeholderOfUserNameView.isHidden = true
        }
    }
    
    // ツイートプレースホルダを表示/非表示するメソッド
    func tweetViewDidChange() {
        if tweetView.text.count == 0 {
            placeholderOfTweetView.isHidden = false
        } else {
            placeholderOfTweetView.isHidden = true
        }
    }
    
    // tweetViewの文字数が140文字以下か検証するメソッド
    // （文字制限に対してユニットテストを行うために、文字数検証処理だけを切り出した）
    func validation(tweet: String) -> Bool{
        let isLessThanOrEqual = tweet.count <= 140
        return isLessThanOrEqual
    }
 
    // tweetViewの文字数をtextCountLabelに表示し、140文字をしきい値にして文字の色を変更するメソッド
    func displayTextCountLabel(tweetable: Bool) {
        textCountLabel.text = String("残り \(140 - tweetView.text.count)文字")
        if tweetable {
            textCountLabel.textColor = .systemGray
        } else {
            textCountLabel.textColor = .red
        }
    }
    
    // tweetDataをrealmに保存するメソッド
    func saveData(currentUserName userName: String, currentTweet tweet: String) {
        let realm = try! Realm()
        try! realm.write {
            tweetData.userName = userName
            tweetData.tweet = tweet
            tweetData.date = dateFormatter.string(from: Date())
            // realmにツイートデータを保存するメソッド（update引数はプライマリキーがあるときに必要）
            realm.add(tweetData, update: .modified)
        }
    }
}

