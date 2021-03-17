## アプリ名
Easy-Virtual-Trip
## 概要
このアプリでは日本全国の市区町村をランダムに選出し、選ばれた地域の観光施設情報を表示します。
そしてユーザーが行きたい施設を選択し、選ばれた場所のGoogle Street Viewを写真で見ることができます。
## 本番環境
http://52.199.217.152/
## Basic認証
ユーザー名：admin
パスワード：1234
## 製作背景(意図)
製作しようとしたきっかけは２点あります。
1. コロナ禍によって中々旅行に行けない昨今、模擬的な観光を体験できないかと思い製作しました。リアルな想像ができるために、GoogleStreetViewの写真を使用し、現地の天気・気温表示を行いました。
2.  私自身旅行に行きたいが、そもそも旅行に行きたいと思う場所がない、と感じていました。その問題を解決するため、ランダムに旅行先を設定し、新しい発見になればと思いました。

## DEMO
### トップページ+市区町村の表示
![EasyVirtualTrip1](https://user-images.githubusercontent.com/78014222/111448787-1ab3ef80-8752-11eb-9ed0-5b757454306f.gif)
### 選択された地域の施設情報表示(行きたい場所選択画面)
![EasyVirtualTrip2](https://user-images.githubusercontent.com/78014222/111449008-5484f600-8752-11eb-8e95-47a97ee8fe5d.gif)
### GoogleStreetView写真のギャラリー画面
![EasyVirtualTrip3](https://user-images.githubusercontent.com/78014222/111449317-a2016300-8752-11eb-905a-df457940defe.gif)
## 工夫したポイント
特に工夫した点は３点あります。
1. ユーザーが操作する工数をできるだけ減らし、サイトからの離脱を避けるようにしました。
2. データベースに保存する主な内容は市区町村と緯度経度のみで、ユーザーに待ち時間をなるべく作らないようにしています。
3. より正確な位置のストリートビューを表示させたかったので、緯度経度をdecimal型で格納しています。

## 使用技術(開発環境)
### バックエンド
Ruby,Ruby on Rails
### フロントエンド
scss,JavaScript
### インフラ
AWS(EC2),Capistrano
### Webサーバー(本番環境)
nginx
### アプリケーションサーバー(本番環境)
unicorn
### ソース管理
GitHub,GitHubDesktop
### エディタ
vsコード
### 使用API
- resas地域経済分析システム
-  Flickr API Services
- OpenWeatherAPI
*↓以下はGoogleAPI↓*
-   Places API
-   Maps JavaScript API
-   Geocoding API
-   Street View Static API

## 課題や今後実装したい機能
現在、Street View Static APIによる写真取得は、フロントエンドで行っており、セキュリティの観点からバックエンドでの処理へ変更したいと思っています。Street View Static APIを叩くと、blob型の写真データが返ってくるため、バイナリ形式からjpg形式などに変換する技術でhtmlへ反映したいと思います。
## DB設計
### plans

|Column|Type  |Option     |
|------|------|-----------|
|name  |string|null :false|
  

##### Associations
has_one :visit_place
  

### visit_places

| Column | Type | Option |
|--------------|------------|-------------|
| prefecture | string | null :false |
| municipality | string | null :false |
|longitude|decimal||
|latitude|decimal||
| plan | references | null :false |

#### Associations

belongs_to :plan
geocoded_by  :municipality
	after_validation  :geocode, if:  :municipality_changed?

### visit_points

| Column | Type | Option |
|-----------|------------|-------------|
| latitude | string | null :false |
| longitude | string | null :false |
| plan | references | null :false |

  

#### Associations

belongs_to  :visit_place
  
