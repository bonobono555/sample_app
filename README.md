# README

# バージョン情報
ruby 2.6.6
rails 6.0.3

# 環境構築方法

1. このリポジトリをcloneする
```
git clone git@github.com:bonobono555/sample_app.git
```

2. yarn install
```
yarn install
```

3. bundle install
```
bundle install
```

4. DBマイグレーション
```
rails db:migrate
```

5. railsサーバー起動
```
rails server
```

6. 起動確認
   
http://127.0.0.1:3001  
http://127.0.0.1:3001/login  
http://127.0.0.1:3001/api/products/search?min_price=100