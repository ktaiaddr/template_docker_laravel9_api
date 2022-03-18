# Laravel9の開発用docker-composeリポジトリ

以下のホスト名で環境を作る場合（設定するホストによって変えてください）
```
local.xxxxx.siteengine.co.jp
```

### hostsファイルにホスト名を設定(例)
```ini
127.0.0.1	local.xxxxx.siteengine.co.jp
````

### .envファイルにホストを設定(例)
.env.sampleをコピーして.envを設置する
```dotenv
#開発サイトのホスト名を指定する
HTTP_CONF_SERVER_NAME=local.xxxxx.siteengine.co.jp
```

### コマンドで証明書作成
```bash
bash docker_config/web/create_ssl_files.sh
```

### docker環境立ち上げ(初回はビルドが走ります)
```bash
 docker-compose up -d
 ```

ブラウザの警告を消すには、ssl.crtをブラウザにインポートする

以下のコマンドでコンテナに接続する
```bash
bash docker_it_web.sh 
 ```

設定したホスト名でアクセスする
```bash
https://local.service.siteengine.co.jp/
```

ララベルインストール
```bash
docker exec -w /var/www/html $(docker ps -a | awk '{if($NF~/_laravel_/){print $NF}}') composer create-project --prefer-dist laravel/laravel:^9.0 laravel9
docker exec $(docker ps -a | awk '{if($NF~/_laravel_/){print $NF}}') bash -c  "chmod -R 777 /var/www/html/laravel9/storage"
```

