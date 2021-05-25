## テーブル設計

### User モデル

| カラム名        | データ型 | 備考           |
| --------------- | -------- | -------------- |
| user_name       | string   | ユーザー名     |
| email           | text     | メールアドレス |
| password_digest | string   | パスワード     |

### Task モデル

| カラム名  | データ型 | 備考     |
| --------- | -------- | -------- |
| task_name | string   | タスク名 |
| title     | text     | タイトル |
| content   | string   | 内容     |

### Label モデル

| カラム名   | データ型 | 備考     |
| ---------- | -------- | -------- |
| label_name | string   | ラベル名 |

## Heroku へのデプロイ手順

(Vagrant 環境)

### 1.Heroku にログイン

```ruby
$ heroku login -i
```

### 2.Heroku に新しいアプリケーションを作成

```ruby
$ heroku create
```

### 3.Heroku stack を変更

```ruby
$ heroku stack:set heroku-18
```

**※バージョン確認する場合**

```ruby
$ heroku stack
```

### 4.Heroku buildpack を追加

```ruby
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```

### 5.アセットプリコンパイルを実行

```ruby
$ rails assets:precompile RAILS_ENV=production
```

### 6.git add、git commit

```ruby
$ git add -A
$ git commit -m "commit message"
```

### 7.Heroku にデプロイ

```ruby
$ git push heroku master
```

**ブランチを指定して Heroku master へプッシュする場合**

```ruby
$ git push heroku branchname:master
```

### マイグレーション

```ruby
$ heroku run rails db:migrate
```

### Heroku サーバー再起動

```ruby
$ heroku restart
```
