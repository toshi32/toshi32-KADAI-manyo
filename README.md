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
