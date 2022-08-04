//
//  TweetTableViewCell.swift
//  TwitterSampleApp
//
//  Created by 後藤勇 on 2022/08/02.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet var userName: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var tweet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(tweetDataModel: TweetDataModel) {
        self.userName.text = tweetDataModel.userName as String
        self.date.text = tweetDataModel.date as String
        self.tweet.text = tweetDataModel.tweet as String
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
