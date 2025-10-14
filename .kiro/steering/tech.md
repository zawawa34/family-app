# Technology Stack - Family App

## アーキテクチャ

Family AppはRails 8の最新機能を活用したモノリシックWebアプリケーションです。

### 設計原則
- Rails Way に従った標準的な構成
- Hotwireによるモダンなフロントエンド体験
- テスト駆動開発（TDD）による品質保証
- Spec-Driven Development（SDD）による仕様管理

## バックエンド

### 言語とフレームワーク
- **Ruby**: 3.4.7 (mise管理)
- **Rails**: 8.0.3
- **Webサーバー**: Puma 7.0+

### データベース
- **開発環境**: SQLite 3 (storage/development.sqlite3)
- **テスト環境**: SQLite 3 (storage/test.sqlite3)
- **本番環境**: SQLite 3 (複数DB構成)
  - Primary: storage/production.sqlite3
  - Cache: storage/production_cache.sqlite3
  - Queue: storage/production_queue.sqlite3
  - Cable: storage/production_cable.sqlite3

### Rails 8 固有機能
- **Solid Cache**: データベースベースのキャッシュ
- **Solid Queue**: データベースベースのジョブキュー
- **Solid Cable**: データベースベースのAction Cable

## フロントエンド

### フレームワークとライブラリ
- **Hotwire**: SPA風の体験を実現
  - **Turbo**: ページ遷移の高速化
  - **Stimulus**: 軽量JavaScriptフレームワーク
- **Tailwind CSS**: ユーティリティファーストのCSSフレームワーク（v4.x）
- **Importmap**: ES modules対応のJavaScript管理

### アセット管理
- **Propshaft**: モダンなアセットパイプライン

## テスト

### テストフレームワーク
- **RSpec Rails**: 7.x
  - spec_helper.rb: RSpecコア設定
  - rails_helper.rb: Rails統合設定

### テストサポートライブラリ
- **Factory Bot**: テストデータの作成
- **Faker**: ダミーデータの生成

### テスト設定
```ruby
# .rspec設定
--require spec_helper
--format documentation
--color
```

### テスト実行コマンド
```bash
# 全テスト実行
mise exec -- bundle exec rspec

# 特定ファイルのテスト
mise exec -- bundle exec rspec spec/models/user_spec.rb

# 特定の行のテスト
mise exec -- bundle exec rspec spec/models/user_spec.rb:10
```

## 開発環境

### 必須ツール
- **mise**: Rubyバージョン管理
- **Bundler**: gem依存関係管理
- **Docker**: コンテナ化とデプロイ（オプション）

### 開発ツール
- **Rubocop**: コードスタイルチェック（Rails Omakase設定）
- **Brakeman**: セキュリティ脆弱性スキャン
- **Debug**: デバッグツール

### エディタサポート
- Claude Code: AI支援開発環境
- Kiro: Spec-Driven Development サポート

## よく使うコマンド

### アプリケーション起動
```bash
# 開発サーバー起動
mise exec -- bin/dev

# Railsコンソール
mise exec -- bin/rails console

# データベースマイグレーション
mise exec -- bin/rails db:migrate

# データベースセットアップ
mise exec -- bin/rails db:setup
```

### テスト
```bash
# 全テスト実行
mise exec -- bundle exec rspec

# モデルテストのみ
mise exec -- bundle exec rspec spec/models

# RSpecジェネレータ使用例
mise exec -- bin/rails generate rspec:model User
mise exec -- bin/rails generate rspec:controller Users
```

### コード品質チェック
```bash
# Rubocop実行
mise exec -- bundle exec rubocop

# Rubocop自動修正
mise exec -- bundle exec rubocop -a

# セキュリティスキャン
mise exec -- bundle exec brakeman
```

### Bundler
```bash
# gem インストール
mise exec -- bundle install

# gem 更新
mise exec -- bundle update

# gem情報確認
mise exec -- bundle info [gem名]
```

## 環境変数

### 開発環境で必要な環境変数
```bash
RAILS_ENV=development
RAILS_MAX_THREADS=5
```

### 本番環境で必要な環境変数
```bash
RAILS_ENV=production
RAILS_MASTER_KEY=<credentials.yml.encの暗号化キー>
SECRET_KEY_BASE=<Railsのsecret key>
```

## ポート設定

### 標準ポート
- **Rails開発サーバー**: 3000
- **Puma本番サーバー**: 3000（設定により変更可能）

## デプロイ

### デプロイツール
- **Kamal**: Docker対応のデプロイツール
- **Thruster**: HTTP asset caching/compression

### コンテナ化
- Dockerfile完備
- Docker Composeサポート
- Kamal設定ファイル (config/deploy.yml)

## 依存関係管理

### 主要なGem
```ruby
# 本番環境
gem "rails", "~> 8.0.3"
gem "puma", ">= 5.0"
gem "sqlite3", ">= 2.1"
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap"

# 開発・テスト環境
gem "rspec-rails", "~> 7.0"
gem "factory_bot_rails"
gem "faker"
gem "debug"
gem "brakeman"
gem "rubocop-rails-omakase"

# 開発環境
gem "web-console"

# デプロイ
gem "kamal"
gem "thruster"
```

## セキュリティ

### セキュリティ対策
- Railsのセキュリティ機能をフル活用
- 定期的なBrakemanスキャン
- 依存関係の定期的な更新
- credentials.yml.encによる秘密情報の暗号化

### ベストプラクティス
- Strong Parametersの使用
- CSRF保護の有効化
- SQLインジェクション対策（ActiveRecordの適切な使用）
- XSS対策（ERBの自動エスケープ）
