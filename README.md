# README

# Name
 
# VINFASH

 
# Description

The purpose of this app is making friends who likes vintage clothing and postting your favarite one.

このWEBアプリケーションは古着好きの友達作り、投稿の閲覧を目的として作られました。

# DEMO
 notification
 
 
 user page
 
 
 chat
 
 

 
# Features
 
* Create an accaunt.
* Following other users
* Chating with other users.
* Posting photos.
* Sending  comments to other's post
* Announcing your any events which will take place before long.
 
* This app has notification. if you receive that, it shows someone follows you, texts you, or makes comments on your posts.
 
*記事関連
    投稿機能
    一覧表示機能
    詳細表示機能
    削除機能
    編集機能
    プレビュー機能
    
*ユーザー関連
    登録機能
    よく行く買い物エリアの登録機能
    編集機能(アドレス・パスワード)
    管理ユーザー追加機能
    ログイン・アウト機能
    
*チャット機能
    チャット機能
    最新チャット一覧

*コメント関連
    コメント投稿機能
    削除機能
    
*友達関連
    フォロー機能
    チャット機能

*通知機能
    フォロー通知機能
    メッセージ通知機能
    投稿に対するコメント通知機能
    
*お問い合わせ機能
    お問い合わせを送信機能


# Requirement
    
     *ruby 2.6.3
     *Rails 5.0.7.2
     *html
     *css 
     *javascript

Library(gem)
    
    *sqlite3  1.3.13
    *puma
    *jquery-rails
    *bootstrap
    *carrierwave
    *devise
    *seed_fu 2.3
    *font-awesome-rails
    *data-confirm-moda
    *kaminari ページネーション 0.17.0

# Setup
 


*carrierwave

$ bundle install
$ rails g migration add_image_to_articles カラム名:string
$ rails db:migrate
$ rails g uploader Image
mount_uploader :image, ImageUploader



*devise

$ rails g devise:install
$ rails g devise user
$ rails db:migrate
$ rails g devise：controllers users
$ rails g devise:views

*bootstrap

$ rails g bootstrap:install



# Usage

you can post something without photo.

Two users follow each other, then they can chat.

 
# License

This software is released under the MIT License, see LICENSE.

# Note
 
Everyone can see user's posts, but if you would like to enjoy anything else, you have to sign up or logn in.

投稿、イベントの閲覧はできますが、他の機能を使う場合はSing Upまたは、Logn inが必要となります。

*simple accaunt   

*you can use the one  (テスト用にお使いください。)




# Author
 
* Koki Miura　　
* Toyo univercity
* miurak565@gmail.com
 
* 三浦 光樹　　
* 東洋大学
* miurak565@gmail.com
 
