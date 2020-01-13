# Byebye frizzy hair beauty salon

 
# Description

This application is making reservations	web site created based on hair salon web site.
(This hair salon's name dose not actually exsit.)

Create reservations to hava hair cut.

Registar new staffs and menus.

edit staffs and menus

Create staff's schedules.


このWEBアプリケーションは美容サロンの予約サイトをモデルに作られたアプリです。

ヘアカットの予約をします。

新しいスタッフとメニューを登録します。

スタッフとメニューの編集をします。

スタッフのスケジュールを作成します。

# DEMO
 Choosing Menus
 
 
 Choosing Date
 
 
 Making staff's schedules
 
 
 Making sure staff's schedules
 
 

 
# Features
 
* Create and Update staffs.
* Create and Update menus
* Reserve haricut.
* Create staff schedules.

 
*スタッフ関連
    登録機能
    編集機能
    削除機能
    一覧表示機能

*メニュー関連
    登録機能
    削除機能
    編集機能
    一覧表示機能



*スケジュール（従業員シフト）関連
    シフト表
    登録機能


    
*予約機能
    予約機能
    メニュー選択機能
    スタッフ選択機能
    日時選択機能
    カスタマー詳細機能
    予約一覧機能
    予約削除機能
    予約検索機能


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
    *therubyracer
    *less-rails
    *twitter-bootstrap-railss
    *'sprockets', '3.7.2'
    *'execjs'
    *carrierwave
    *seed_fu 2.3
    *whenever
    *basic認証
    
    

# Setup
 
*carrierwave

$ bundle install
$ rails g migration add_image_to_articles カラム名:string
$ rails db:migrate
$ rails g uploader Image
mount_uploader :image, ImageUploader





*bootstrap

$ rails g bootstrap:install





*whenever

whenever --update-crontab
whenever --clear-crontab
whenever





*basic認証

vim ~/.bash_profile
export BASIC_AUTH_USER='xxxx'
export BASIC_AUTH_PASSWORD='xxxx'
$ source ~/.bash_profile






# Usage

It is available to create and update staff's infomation.

It is available to create and update menus.

It is available to make staff's schedules.

It is available to make staff's schedules.

It is available to make staff's schedules.

It is available to choose menu.

It is available to choose staff.

It is available to choose date and time.




# Author
 
* Koki Miura　　
* Toyo univercity
* 三浦 光樹　　
* 東洋大学
 
