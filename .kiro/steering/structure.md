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
├── docs/                  # ドキュメント
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
│   ├── application_controller.rb  # Devise統合とヘルパーメソッド
│   ├── home_controller.rb         # ホーム画面
│   ├── user/
│   │   ├── registrations_controller.rb  # 招待ベース登録
│   │   └── invitations_controller.rb    # 招待管理（管理者専用）
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
│   ├── user.rb          # ユーザー基本情報と役割管理
│   ├── user/
│   │   ├── database_authentication.rb  # Devise認証情報
│   │   └── invitation.rb               # 招待トークン管理
│   └── concerns/        # モデルコンサーン
└── views/                # ビュー
    ├── layouts/         # レイアウトテンプレート
    ├── home/            # ホーム画面
    ├── user/
    │   └── invitations/ # 招待管理画面
    ├── user_database_authentications/  # Devise認証画面
    │   ├── sessions/    # ログイン/ログアウト
    │   ├── registrations/  # 新規登録/アカウント編集
    │   ├── passwords/   # パスワードリセット
    │   ├── shared/      # 共通パーシャル
    │   └── mailer/      # 認証メール
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
│   ├── users.rb        # Userファクトリー
│   └── user/
│       ├── database_authentications.rb  # 認証情報ファクトリー
│       └── invitations.rb               # 招待ファクトリー
├── support/             # テストサポートファイル
│   └── factory_bot.rb  # Factory Bot設定
├── models/              # モデルテスト
│   ├── user_spec.rb    # Userモデルテスト
│   └── user/
│       ├── database_authentication_spec.rb  # 認証情報テスト
│       └── invitation_spec.rb               # 招待テスト
├── requests/            # リクエストテスト
│   └── user/
│       ├── sessions_spec.rb       # ログイン/ログアウトテスト
│       ├── registrations_spec.rb  # 登録フローテスト
│       └── invitations_spec.rb    # 招待管理テスト
├── db/                  # データベーステスト
│   └── seeds_spec.rb   # 初期データテスト
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

### docs/ - ドキュメント

プロジェクトドキュメント

```
docs/
├── design-system.md    # 包括的なデザインシステム仕様
│                       # - Apple HIG準拠の原則
│                       # - カラーシステム（階層的定義）
│                       # - タイポグラフィ（9段階スケール）
│                       # - 8ptグリッドシステム
│                       # - コンポーネント設計
│                       # - アクセシビリティ配慮
│                       # - アニメーション・トランジション
└── design-rules.md     # 基本的なデザインルール
                        # - Tailwind CSS標準クラスのみ使用
                        # - コンポーネント別実装例
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
│   ├── xxxxxx_devise_create_user_database_authentications.rb  # Devise認証テーブル
│   ├── xxxxxx_create_users.rb                                # Userテーブル
│   └── xxxxxx_create_user_invitations.rb                     # 招待テーブル
├── cache_migrate/       # Solid Cacheマイグレーション
├── queue_migrate/       # Solid Queueマイグレーション
├── cable_migrate/       # Solid Cableマイグレーション
└── seeds.rb            # 初期データ（初期管理者作成）
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
- bcryptによるパスワードハッシュ化
- 役割ベースアクセス制御（RBAC）
- 招待トークンベースの登録システム

### パフォーマンス
- N+1クエリの回避（includes、eager_load）
- キャッシング戦略（Solid Cache）
- バックグラウンドジョブの活用（Solid Queue）

### 可読性と保守性
- 明確なネーミング
- 適切なコメント（日本語）
- 小さなメソッド/クラス
- 一貫したコーディングスタイル（Rubocop）

### デザイン一貫性
- **デザインシステムの遵守**: `docs/design-system.md`に定義されたルールに従う
- **Tailwind CSS標準クラスのみ**: カスタムCSSは定義せず、Tailwindのデフォルトクラスで完結
- **コンポーネントの再利用**: デザインドキュメントのコンポーネントライブラリを活用
- **アクセシビリティチェックリスト**: 新規コンポーネント作成時に11項目を確認
  - 定義されたカラーパレットの使用
  - 8ptグリッドシステムに基づいた余白
  - 適切な角丸サイズ
  - タップターゲットサイズ44px以上
  - フォーカス状態の定義
  - ホバー・アクティブ状態の定義
  - トランジションの適用（duration-200）
  - レスポンシブ対応（モバイルファースト）
  - カラーコントラスト（4.5:1以上）
  - セマンティックHTMLの使用
  - ARIAラベルの適切な使用
