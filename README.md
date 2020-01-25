# Byebye frizzy hair beauty salon

 
# Description

* This application is making reservations	web site created based on hair salon web site. (This hair salon's name dose not actually exsit.)

* Create reservations to hava hair cut.

* Registar new staffs and menus.

* edit staffs and menus

* Create staff's schedules.

* このWEBアプリケーションは美容サロンの予約サイトをモデルに作られたアプリです。

* ヘアカットの予約をします。

* 新しいスタッフとメニューを登録します。

* スタッフとメニューの編集をします。

* スタッフのスケジュールを作成します。

# DEMO

 Home page

 <img width="1440" alt="スクリーンショット 2020-01-09 16 23 11" src="https://user-images.githubusercontent.com/50481755/72299050-1cdc7300-36a3-11ea-830f-3b0d365ea9ac.png">


 Choosing Menus
 
 <img width="1125" alt="スクリーンショット 2020-01-14 07 43 35" src="https://user-images.githubusercontent.com/50481755/72299167-6200a500-36a3-11ea-985f-26ffe18d99fe.png">

 
 Choosing Date
 
 <img width="1198" alt="スクリーンショット 2020-01-14 07 44 06" src="https://user-images.githubusercontent.com/50481755/72299106-3b426e80-36a3-11ea-9a08-7ee5365533b4.png">
 
 
 Making staff's schedules
 
 <img width="1226" alt="スクリーンショット 2020-01-14 07 41 54" src="https://user-images.githubusercontent.com/50481755/72298966-e7378a00-36a2-11ea-8363-08ebe591e4bf.png">

 
 Making sure staff's schedules
 
 <img width="907" alt="スクリーンショット 2020-01-14 07 43 03" src="https://user-images.githubusercontent.com/50481755/72299205-7c3a8300-36a3-11ea-9501-ba6629f88ed4.png">


 
# Features
 
* Create and Update staffs.
* Create and Update menus
* Reserve haricut.
* Create staff schedules.

<dl>
    <dt>スタッフ関連</dt>
    <dd>登録機能</dd>
    <dd>編集機能</dd>
    <dd>削除機能</dd>
    <dd>一覧表示機能</dd>
</dl>

<dl>
    <dt>メニュー関連</dt>
    <dd>登録機能</dd>
    <dd>編集機能</dd>
    <dd>削除機能</dd>
    <dd>一覧表示機能</dd>
</dl>

<dl>
    <dt>スケジュール（従業員シフト）関連</dt>
    <dd>シフト表</dd>
    <dd>登録機能</dd>
</dl>   

<dl>
    <dt>予約機能関連</dt>
    <dd>予約機能</dd>
    <dd>メニュー選択機能</dd>
    <dd>スタッフ選択機能</dd>
    <dd>日時選択機能</dd>
    <dd>カスタマー詳細機能</dd>
    <dd>予約一覧機能</dd>
    <dd>予約削除機能</dd>
    <dd>予約検索機能</dd>
</dl>   
    

# Requirement
    
    ruby 2.6.3
    Rails 5.0.7.2
    html
    css 
    javascript
    sqlite3  1.3.13
    puma
    jquery-rails
    therubyracer
    less-rails
    twitter-bootstrap-railss
    carrierwave
    seed_fu 2.3
    whenever
    basic認証
    

# Setup
 
* carrierwave

`$ bundle install`<br>
`$ rails g migration add_image_to_articles カラム名:string`<br>
`$ rails db:migrate`<br>
`$ rails g uploader Image`<br>
`mount_uploader :image, ImageUploader`<br>

* bootstrap

`$ rails g bootstrap:install`<br>

* whenever

`whenever --update-crontab`<br>
`whenever --clear-crontab`<br>
`whenever`<br>

* basic認証

`vim ~/.bash_profile`<br>
`export BASIC_AUTH_USER='xxxx'`<br>
`export BASIC_AUTH_PASSWORD='xxxx'`<br>
`$ source ~/.bash_profile`<br>



# Usage

It is available to create and update staff's infomation.

It is available to create and update menus.

It is available to make staff's schedules.

It is available to make staff's schedules.

It is available to make staff's schedules.

It is available to choose menu.

It is available to choose staff.

It is available to choose a date and time.




# Author
 
* Koki Miura　　
* Toyo university

* 三浦 光樹　　
* 東洋大学
 
