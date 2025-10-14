# Project Structure - Family App

## ルートディレクトリの構成

```
family-app/
├── .claude/              # Claude Code設定とコマンド
├── .github/              # GitHub Actions設定
├── .kamal/               # Kamalデプロイ設定
├── .kiro/                # Kiro Spec-Driven Development
│   ├── specs/           # 仕様ドキュメント
│   └── steering/        # ステアリングドキュメント（本ファイル含む）
├── app/                  # アプリケーションコード
├── bin/                  # 実行可能スクリプト
├── config/               # 設定ファイル
├── db/                   # データベース関連
├── lib/                  # ライブラリコード
├── log/                  # ログファイル
├── public/               # 静的ファイル
├── script/               # スクリプト
├── spec/                 # RSpecテスト
├── storage/              # Active Storage / データベースファイル
├── tmp/                  # 一時ファイル
├── vendor/               # サードパーティのコード
├── CLAUDE.md             # Claude Codeプロジェクト設定
├── Dockerfile            # Dockerイメージ定義
├── Gemfile               # Ruby依存関係
├── mise.toml             # Rubyバージョン管理
├── Procfile.dev          # 開発プロセス定義
├── Rakefile              # Rakeタスク
└── README.md             # プロジェクト説明
```

## サブディレクトリの詳細

### app/ - アプリケーションコード

Rails MVCアーキテクチャの中核

```
app/
├── assets/               # アセットファイル
│   ├── images/          # 画像ファイル
│   └── stylesheets/     # CSSファイル（Tailwind設定含む）
├── controllers/          # コントローラー
│   ├── application_controller.rb
│   └── concerns/        # コントローラーコンサーン
├── helpers/              # ビューヘルパー
│   └── application_helper.rb
├── javascript/           # JavaScriptファイル
│   ├── application.js   # エントリーポイント
│   └── controllers/     # Stimulusコントローラー
├── jobs/                 # バックグラウンドジョブ
│   └── application_job.rb
├── mailers/              # メーラー
│   └── application_mailer.rb
├── models/               # モデル
│   ├── application_record.rb
│   └── concerns/        # モデルコンサーン
└── views/                # ビュー
    ├── layouts/         # レイアウトテンプレート
    └── pwa/            # PWA関連ビュー
```

### config/ - 設定ファイル

アプリケーション全体の設定

```
config/
├── application.rb        # アプリケーション基本設定
├── boot.rb              # ブート設定
├── cable.yml            # Action Cable設定
├── cache.yml            # Solid Cache設定
├── credentials.yml.enc  # 暗号化された認証情報
├── database.yml         # データベース設定
├── deploy.yml           # Kamalデプロイ設定
├── environment.rb       # 環境設定読み込み
├── environments/        # 環境別設定
│   ├── development.rb  # 開発環境
│   ├── production.rb   # 本番環境
│   └── test.rb         # テスト環境
├── importmap.rb         # Import Map設定
├── initializers/        # 初期化処理
│   ├── assets.rb
│   ├── content_security_policy.rb
│   ├── filter_parameter_logging.rb
│   ├── inflections.rb
│   └── permissions_policy.rb
├── locales/             # 国際化ファイル
│   └── en.yml
├── master.key           # credentials.yml.encの復号化キー
├── puma.rb              # Puma設定
├── queue.yml            # Solid Queue設定
├── recurring.yml        # 定期実行ジョブ設定
├── routes.rb            # ルーティング定義
└── storage.yml          # Active Storage設定
```

### spec/ - RSpecテスト

テスト駆動開発（TDD）のためのテストコード

```
spec/
├── factories/           # Factory Botファクトリー定義
│   └── .keep
├── support/             # テストサポートファイル
│   └── factory_bot.rb  # Factory Bot設定
├── models/              # モデルテスト（作成時に配置）
├── controllers/         # コントローラーテスト（作成時に配置）
├── requests/            # リクエストテスト（作成時に配置）
├── system/              # システムテスト（作成時に配置）
├── rails_helper.rb      # Rails統合RSpec設定
└── spec_helper.rb       # RSpecコア設定
```

### .kiro/ - Spec-Driven Development

Kiroによる仕様駆動開発サポート

```
.kiro/
├── specs/               # 機能仕様ドキュメント
│   └── [feature-name]/ # 機能ごとのディレクトリ
│       ├── requirements.md  # 要件定義
│       ├── design.md       # 技術設計
│       └── tasks.md        # 実装タスク
└── steering/            # ステアリングドキュメント
    ├── product.md      # プロダクト概要
    ├── tech.md         # 技術スタック
    └── structure.md    # プロジェクト構造（本ファイル）
```

### .claude/ - Claude Code設定

AI支援開発環境の設定

```
.claude/
├── commands/            # カスタムスラッシュコマンド
│   ├── kiro:spec-*.md  # Kiro関連コマンド
│   └── kiro:steering*.md
└── CLAUDE.md           # グローバル設定へのリンク
```

### db/ - データベース関連

マイグレーションとスキーマ

```
db/
├── migrate/             # マイグレーションファイル
├── cache_migrate/       # Solid Cacheマイグレーション
├── queue_migrate/       # Solid Queueマイグレーション
├── cable_migrate/       # Solid Cableマイグレーション
└── seeds.rb            # 初期データ
```

## コード構成パターン

### MVCパターン

標準的なRails MVCアーキテクチャに従う

- **Model**: app/models/ - データとビジネスロジック
- **View**: app/views/ - プレゼンテーション層
- **Controller**: app/controllers/ - リクエスト処理とフロー制御

### Concernsパターン

共通ロジックの再利用

- **app/models/concerns/**: モデル間で共有するモジュール
- **app/controllers/concerns/**: コントローラー間で共有するモジュール

### Hotwireパターン

モダンなフロントエンド構成

- **Turbo Frames**: 部分的なページ更新
- **Turbo Streams**: リアルタイム更新
- **Stimulus Controllers**: app/javascript/controllers/ - JavaScriptの動作定義

### テストパターン

RSpecによるテスト構成

```ruby
# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '有効なファクトリーを持つこと' do
      expect(build(:user)).to be_valid
    end
  end
end
```

## ファイル命名規則

### Ruby/Railsファイル
- **クラス/モジュール**: スネークケース（例：user_profile.rb → UserProfile）
- **テストファイル**: 元のファイル名 + _spec.rb（例：user.rb → user_spec.rb）
- **ファクトリー**: 複数形（例：users.rb）

### JavaScript/Stimulus
- **コントローラー**: スネークケース + _controller.js（例：hello_controller.js）
- **識別子**: data-controller="hello"

### CSS/Tailwind
- **スタイルシート**: application.tailwind.css
- **カスタムCSS**: コンポーネントやユーティリティごとに分離

### 仕様ドキュメント
- **.kiro/specs/[feature-name]/**:
  - requirements.md: 要件定義
  - design.md: 技術設計
  - tasks.md: 実装タスク

## Import/Require構成

### Ruby
```ruby
# 標準的なrequire順序
require 'rails_helper'  # テストファイル
require_relative '../path/to/file'  # 相対パス
```

### JavaScript (Importmap)
```javascript
// app/javascript/application.js
import "@hotwired/turbo-rails"
import "controllers"
```

### Stimulus Controllers
```javascript
// app/javascript/controllers/index.js
// すべてのコントローラーを自動登録
import { application } from "./application"
```

## 主要なアーキテクチャ原則

### Rails Way
- Convention over Configuration: 設定より規約
- DRY (Don't Repeat Yourself): 重複を避ける
- REST: RESTfulなリソース設計

### テスト駆動開発（TDD）
1. テストを先に書く（Red）
2. 最小限の実装でテストを通す（Green）
3. リファクタリング（Refactor）

### Spec-Driven Development（SDD）
1. 仕様を明確化（/kiro:spec-init, /kiro:spec-requirements）
2. 技術設計を作成（/kiro:spec-design）
3. タスクに分解（/kiro:spec-tasks）
4. TDDで実装（/kiro:spec-impl）

### セキュリティファースト
- Strong Parametersの徹底
- CSRFトークンの使用
- SQLインジェクション対策
- XSS対策

### パフォーマンス
- N+1クエリの回避（includes、eager_load）
- キャッシング戦略（Solid Cache）
- バックグラウンドジョブの活用（Solid Queue）

### 可読性と保守性
- 明確なネーミング
- 適切なコメント（日本語）
- 小さなメソッド/クラス
- 一貫したコーディングスタイル（Rubocop）
