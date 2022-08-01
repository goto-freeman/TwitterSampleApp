//
//  HomeViewController.swift
//  TwitterSampleApp
//
//  Created by 後藤勇 on 2022/07/31.
//

import Foundation
import UIKit


class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var tweetDataList: [TweetDataModel] = []
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        setTweetData()
    }
    
    func setTweetData() {
        for i in 1...5 {
            let tweetDataModel = TweetDataModel(userName: "\(i)人目のユーザー", tweet: "\(i)ツイート目")
            tweetDataList.append(tweetDataModel)
        }
    }
}


extension HomeViewController: UITableViewDataSource {
    // セクション（リスト）内のセル数を決めるメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetDataList.count
    }
    
    // ”セルの”インスタンスを生成するメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ここは任意の文字列")
        let tweetDataModel: TweetDataModel = tweetDataList[indexPath.row]
        cell.textLabel?.text = tweetDataModel.userName
        cell.detailTextLabel?.text = tweetDataModel.tweet
        return cell
    }
}




// 動画で復習しながらViewを作り上げていってる。
// 次はChapter8・Step8・メモ詳細画面を作成

