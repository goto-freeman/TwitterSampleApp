# **Twitter Sample App**

### 要件

- 全体
 - 構成画面は以下の3つ。
   - 「ホーム画面」　：ツイートを表示するタイムライン
   - 「ツイート画面」：新規ツイートを入力し投稿する画面
   - 「編集画面」　　：既存のツイートを編集する画面
 - ホーム画面を親画面とし、ツイート画面、編集画面は子画面とする。
 - 子画面から子画面への移動はできない。
 - ホーム画面のからの遷移方向は以下に従う。
   - ホーム画面 → ツイート画面：下から重なってきて、下に戻る
   - ホーム画面 → 編集画面　　：右から重なってきて、右に戻る


- ホーム画面
  - 過去のツイートが新しい順番に上から表示される。
  - 各ツイートには「ユーザー名」と「ツイート内容」が表示される。
  - ツイートの文章の長さによって、ひとつのツイートの表示領域が変化する。
  - 画面右下に「ツイートボタン（＋）」が表示されている。
  - ツイートボタンをタップすると、ツイート画面に遷移する。
  - ホーム画面のツイートを左にスワイプすると、「編集」「削除」のメニューが表示される。
  - ホーム画面の「編集」をタップすると、当該ツイートを編集する編集画面に遷移する。
  - ホーム画面の「削除」をタップすると、当該ツイートが削除される。


- ツイート画面
  -
