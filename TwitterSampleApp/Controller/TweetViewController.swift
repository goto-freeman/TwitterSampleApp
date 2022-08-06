//
//  TweetViewController.swift
//  TwitterSampleApp
//
//  Created by 後藤勇 on 2022/08/01.
//

import UIKit


class TweetViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var userNameView: UITextView!
    @IBOutlet weak var tweetView: UITextView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var placeholderOfUserNameView: UILabel!
    @IBOutlet weak var placeholderOfTweetView: UILabel!
    @IBAction func cancelButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tweetButtonAction(_ sender: UIButton) {
        // ここにツイートボタンを押した時のアクションを記述
    }

    
    var userName: String = ""
    var date: String = ""
    var tweet: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetView.delegate = self
        userNameView.delegate = self
        displayTweet()
        UserNameViewDidChange()
        tweetViewDidChange()
        tweetViewCharactersCount()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        tweetViewCharactersCount()
        UserNameViewDidChange()
        tweetViewDidChange()
    }
    
    func configure(tweetData: TweetDataModel) {
        userName = tweetData.userName
        date = tweetData.date
        tweet = tweetData.tweet
    }
    
    func displayTweet() {
        userNameView.text = userName
        tweetView.text = tweet
        tweetButton.setTitle("編集する", for: .normal)
    }
    
    func tweetViewCharactersCount() {
        let NumberOfCharactersRemaining = 140 - tweetView.text.count
        textCountLabel.text = String("残り \(NumberOfCharactersRemaining)文字")
        if NumberOfCharactersRemaining < 0 {
            textCountLabel.textColor = .red
        } else {
            textCountLabel.textColor = .systemGray
        }
    }
    
    func UserNameViewDidChange() {
        if userNameView.text.count == 0 {
            placeholderOfUserNameView.isHidden = false
        } else {
            placeholderOfUserNameView.isHidden = true
        }
    }
    
    func tweetViewDidChange() {
        if tweetView.text.count == 0 {
            placeholderOfTweetView.isHidden = false
        } else {
            placeholderOfTweetView.isHidden = true
        }
    }
}
