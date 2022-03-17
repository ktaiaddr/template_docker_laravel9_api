# Laravel9の開発環境を立ち上げるためのdocker-composeリポジトリ

### hostsファイルにホスト名を設定(例)
```ini
127.0.0.1	local.service.siteengine.co.jp
````

### .envファイルにホストを設定(例)
.env.sampleをコピーして.envを設置する
```dotenv
#開発サイトのホスト名を指定する（自身の開発ホストを決めて設定する）
HTTP_CONF_SERVER_NAME=local.service.siteengine.co.jp
```

### コマンドでSSL証明書作成
```bash
bash docker_config/web/create_ssl_files.sh
```

### docker環境立ち上げ
```bash
bash compose_up.sh
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

docker exec -w /var/www/html lll_web_1 composer create-project --prefer-dist laravel/laravel:^9.0 laravel9
docker exec  lll_web_1 bash -c  "chmod -R 777 /var/www/html/laravel9/storage"

