//
//  TwitterSampleAppTests.swift
//  TwitterSampleAppTests
//
//  Created by 後藤勇 on 2022/07/31.
//

import XCTest
@testable import TwitterSampleApp


class TwitterSampleAppTests: XCTestCase {
    func testTweetViewCharactersCount() throws {
        let vc = TweetViewController()
        let text = "これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字これ5文字・・・・・ここまでで140文字"
        let isLessThanOrEqual = vc.checkTheNumberOfCharacters(tweet: text)
        print("\n■ テストで与えた文字列は \(text.count)文字です。■\n")
        XCTAssertTrue(isLessThanOrEqual)
    }
}



