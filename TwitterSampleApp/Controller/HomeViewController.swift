//
//  HomeViewController.swift
//  TwitterSampleApp
//
//  Created by 後藤勇 on 2022/07/31.
//

import Foundation
import UIKit
import RealmSwift


class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // 新規ツイートボタン（＋）をタップしたときの処理
    @IBAction func addTweetButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tweetViewController = storyboard.instantiateViewController(identifier: "TweetViewController")
        navigationController?.pushViewController(tweetViewController, animated: true)
    }
    
    // ツイートデータモデル変数を定義する
    var tweetDataList: [TweetDataModel] = []
    
    // 一番最初にホーム画面がロードされたときの処理
    override func viewDidLoad() {
        // データソースとデリゲートに自身を定義する
        tableView.dataSource = self
        tableView.delegate = self
        // ホーム画面のtableViewにxibファイル(カスタムセル)を登録する
        tableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        // 必要な数だけテーブルのセルを表示するため、フッタービューに空のUIViewを配置する
        tableView.tableFooterView = UIView()
        // NavigationCotrollerのNavigationBarを隠す（hidden)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // Viewが表示されるたびに行われる処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Realmに保存されたツイートデータをtweetDataListに読み込むメソッドを呼び出す
        setTweetData()
        // tableViewの表示を更新する
        tableView.reloadData()
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
    
    // Realmに保存されたツイートデータをtweetDataListに読み込む
    func setTweetData() {
        let realm = try! Realm()
        let result = realm.objects(TweetDataModel.self)
        tweetDataList = Array(result)
    }
}


// 以下ふたつのメソッドは必須
extension HomeViewController: UITableViewDataSource {
    // セクション（リスト）内のセル数を決めるメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetDataList.count
    }
    
    // ”セルの”インスタンスを生成するメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
        cell.setCell(tweetDataModel: tweetDataList[indexPath.row])
        return cell
    }
}


// デリゲートに必要
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Main.storyboardをインスタンス化し、コード上でstoryboardを使えるようにする
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // storyboard定数のinstantiateViewControllerメソッドを使ってTweetViewControllerをインスタンス化する
        let tweetViewController = storyboard.instantiateViewController(identifier: "TweetViewController") as! TweetViewController
        
        // TableViewCellからツイート画面に遷移した際にツイートデータを渡す
        let tweetData = tweetDataList[indexPath.row]
        tweetViewController.configure(tweet: tweetData)
        
        // タップ後のセルの選択状態を解錠する
        tableView.deselectRow(at: indexPath, animated: true)
        
        // navigationControllerのpushViewcontrollerというメソッドを使って画面遷移処理を定義する
        navigationController?.pushViewController(tweetViewController, animated: true)
    }
    
    // TableViewCellを左にスワイプした際にdelete等のボタンが現れる処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let targetTweet = tweetDataList[indexPath.row]
        let realm = try! Realm()
        try! realm.write {
            // indexPath.rowで指定したツイートデータをrealmから削除する
            realm.delete(targetTweet)
        }
        // indexPath.rowで指定したツイートデータをtweetDataListから削除する
        tweetDataList.remove(at: indexPath.row)
        // indexPath.rowで指定したツイートデータをtableViewから削除する
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // tableViewのcellを左にすワイプしたときに現れるdeleteボタンの表示を削除に変える
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除"
    }
}

