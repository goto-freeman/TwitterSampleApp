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
        tableView.delegate = self
        tableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        tableView.tableFooterView = UIView()
        setTweetData()

    }
    
    var dateFormatter: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ja_JP")
        dateFormat.timeZone = .current
        dateFormat.dateStyle = .long
        dateFormat.timeStyle = .none
        return dateFormat
    }
    
    func setTweetData() {
        // 4ツイート目まで
        for i in 1...9 {
            let tweetDataModel = TweetDataModel(userName: "\(i)人目のユーザー", date: dateFormatter.string(from: Date()), tweet: "\(i)ツイート目")
            tweetDataList.append(tweetDataModel)
        }
        // 5ツイート目
        let tweetDataModel = TweetDataModel(userName: "ごとう", date: dateFormatter.string(from: Date()), tweet: "ああああああああああああああああいうえおかきくけこさしすせそたちつてと\nああああああああああああああああ\nああああああああああああああああ\nああああああああああああああああ\nなにぬねのはひふへほまみむめもやゆよらりるれろわおん")
        tweetDataList.append(tweetDataModel)
        
    }
}


extension HomeViewController: UITableViewDataSource {
    // セクション（リスト）内のセル数を決めるメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetDataList.count
    }
    
    // ”セルの”インスタンスを生成するメソッド。セルはUITableViewCell。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
        cell.setCell(tweetDataModel: tweetDataList[indexPath.row])
        return cell
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 「Main.storyboard」をインスタンス化し、コード上でstoryboardを使えるようにする。
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // storyboard定数のinstantiateViewControllerメソッドを使って「TweetViewController」をインスタンス化する。
        let tweetViewController = storyboard.instantiateViewController(identifier: "TweetViewController") as! TweetViewController
        // タップ後のセルの選択状態を解錠する
        tableView.deselectRow(at: indexPath, animated: true)
        // navigationControllerのpushViewcontrollerというメソッドを使って画面遷移処理を定義
        navigationController?.pushViewController(tweetViewController, animated: true)
    }
}



// 動画で復習しながらViewを作り上げていってる。
// 次はツイート画面作成
// 次はChapter8・Step9・メモ詳細画面にメモの内容を表示させる
