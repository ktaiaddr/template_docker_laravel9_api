# Laravel9の開発環境を立ち上げるためのdocker-composeリポジトリ

### hostsファイルにホスト名を設定(例)
```bash
127.100.100.92	b.n.local
```

### .envファイルにホストを設定(例)
.env.sampleをコピーして.envを設置する
```dotenv
#ローカルIPをどれかユニークなものを指定する（他の開発環境と被らないように設定する）
WEB_IP=127.0.0.1

#開発サイトのホスト名を指定する（自身の開発ホストを決めて設定する）
HTTP_CONF_SERVER_NAME=b.n.local
```
### larave9/.envのコピーを作成して編集する
```dotenv
SANCTUM_STATEFUL_DOMAINS=n.local
SESSION_DOMAIN=.n.local
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

コンテナ内で以下のコマンドでLaravel9をインストールする
```bash
composer create-project --prefer-dist laravel/laravel:^9.0 laravel9
```

設定したホスト名でアクセスする
```bash
https://laravel9.local/
```

モデル、マイグレーション作成、マイグレーション実行、ファクトリ、シーダー作成、シーダー実行サンプル
```bash

#モデル生成
php artisan make:model Hoge -m #マイグレーションファイルも同時に作成

#（マイグレーションだけ作成する場合）
php artisan make:migration

#マイグレーション
#設定
    public function up()
    {
        Schema::create('hoges', function (Blueprint $table) {
            $table->id();
            $table->integer('integer')->comment('数値型');
            $table->string('string')->comment('文字列型');
            $table->text('text')->comment('テキスト型');
            $table->timestamps();
        });
    }

# 実行
php artisan migrate
#（ ロールバック
php artisan migrate:rollback

#ファクトリー
# 生成
php artisan make:factory HogeFactory --model=Hoge

# 設定
    public function definition()
    {
        return [
            'integer' => random_int(1241,1250),
            'string' => $this->faker->realText(50),
            'text' => $this->faker->realText(50)
        ];
    }

#seeder
#作成
php artisan make:seeder HogeSeeder
# 設定
    public function run()
    {
        \App\Models\Hoge::truncate(); //毎回クリアする場合
        \App\Models\Hoge::factory(10)->create();
    }
#実行
php artisan db:seed --class=HogeSeeder

```

### tinkerでユーザ確認(ルートユーザで)
```bash
php artisan tinker
>>> $user = new User;
[!] Aliasing 'User' to 'App\Models\User' for this Tinker session.
=> App\Models\User {#3506}
>>> $user->get();  
#これでもOK
>>> (new User)->get()
```