# Local Mapping

<img width="1430" alt="スクリーンショット 2021-07-06 20 27 17" src="https://user-images.githubusercontent.com/82698260/124592647-a46e0100-de98-11eb-92fb-ebdd032c4021.png">

- [Local Mapping](#local-mapping)
  - [URL](#url)
  - [概要](#概要)
  - [開発環境](#開発環境)
  - [機能一覧](#機能一覧)
  - [開発経緯](#開発経緯)
  - [使い方](#使い方)

***

## URL
  - AWS環境  
  **https://localmap.work/**

  - heroku環境  
  ~~**https://local-mappings.herokuapp.com/**~~

**一時的にBASIC認証は取り消しています。**  
  ~~BASIC認証を設定しております。~~
  - ユーザ名：　　LocalMap4482
  - パスワード：　Mapping9654


## 概要
***

自分のお気に入りのスポットをインターネットで投稿し、共有するWebサイトです。

GoogleMap を使用し、地図にピンを挿入しているため、視覚的にスポットを巡ることができます。
投稿の際も地図にスポットを投稿できます。

お気に入り数ランキングを表示する機能を実装しているので、人気があるスポット巡りをする、ということも可能です。

## 開発環境
***
* Ruby 2.5.3
* Ruby on Rails 5.2.2
* mySQL
* Google Maps API
* Docker
* AdobeXD

### 開発管理
* GitHub

### 開発エディタ
* VisualStudio Code

### 本番環境①
* AWS
* Nginx
* Unicorn
* AWS s3
* SSLサーバ証明書発行

### 本番環境②
* heroku
* AWS s3
* BASIC認証



## 機能一覧
***
* ログイン機能(ユーザ登録機能)
* 投稿機能
  * 画像投稿(carrierwave)
  * 位置情報機能(geocorder)
  * 投稿編集
  * 投稿削除
* いいね機能(Ajax)
* コメント投稿機能(Ajax)
* いいね数ランキング表示機能
* オートコンプリート機能

## 開発経緯
***
いわゆる名所というものはネットで検索するとたくさん情報を入手できます。

しかし、自分が住んでいる地域のようなローカルスポットはあまり情報がなく、これをインターネットで誰でも投稿し・共有できたら便利だなと思い作成しました。

## 使い方
***


**1.メインページ**

<img width="1432" alt="スクリーンショット 2021-07-06 20 32 54" src="https://user-images.githubusercontent.com/82698260/124593256-61605d80-de99-11eb-8595-418846da5f12.png">

いいねランキングが表示されます。  
ゲストユーザとしてユーザ情報の登録をせず利用することもできます。  
※スポットの投稿・コメント投稿・いいね機能は使用できません。


**2.投稿ページ**
<img width="1432" alt="スクリーンショット 2021-07-06 20 38 25" src="https://user-images.githubusercontent.com/82698260/124593973-375b6b00-de9a-11eb-8729-2eec358184c5.png">
ピンを設定し、スポットの投稿ができます。  
位置情報取得の許可を設定いただければ、現在地にピンを設定して投稿できます。


**3.投稿明細画面**
<img width="1404" alt="スクリーンショット 2021-07-06 20 42 24" src="https://user-images.githubusercontent.com/82698260/124594391-b51f7680-de9a-11eb-88ea-08a6e7f5f79a.png">
いいね・コメント投稿ができます。  
(Ajaxで設計しているため再読み込みを伴わずご利用できます。)  
スポットの投稿者の場合、編集・削除が可能です。
