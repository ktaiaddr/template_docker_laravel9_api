# Laravel9の開発用docker-composeリポジトリ

以下のホスト名で環境を作る場合の説明です
```
local.xxxxx.siteengine.co.jp
```
※開発で使うホスト名に応じて変更してください

### hostsファイルにホスト名を設定(例)
```ini
127.0.0.1	local.xxxxx.siteengine.co.jp
````

### 証明書作成
```bash
bash docker_config/web/create_ssl_files.sh
```

### docker環境立ち上げ(初回はビルドが走ります)
```bash
 docker-compose up -d
 ```

ララベルインストール
```bash
docker exec -w /var/www/html $(docker ps -a | awk '{if($NF~/_laravel_/){print $NF}}') composer create-project --prefer-dist laravel/laravel:^9.0 laravel9
docker exec $(docker ps -a | awk '{if($NF~/_laravel_/){print $NF}}') bash -c  "chmod -R 777 /var/www/html/laravel9/storage"
```

設定したホスト名でアクセスする
```bash
local.xxxxx.siteengine.co.jp
```
※ブラウザの警告を消すには、ssl.crtをブラウザにインポートする
