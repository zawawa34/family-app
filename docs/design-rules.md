# デザインルール

## 概要

本ドキュメントは、家族向けアプリケーションのデザインシステムを定義します。
Tailwind CSSのデフォルトクラスのみを使用し、温かみのある親しみやすいUIを実現します。

---

## 技術前提

- **CSSフレームワーク**: Tailwind CSS（デフォルトクラスのみ）
- **カスタマイズ**: 独自CSS定義なし、Tailwind標準クラスで完結
- **ダークモード**: 対応不要

---

## デザイン基本方針

- **目的志向**: 家事の合間にスマホから効率的に操作できるユーザビリティ
- **統一性**: Tailwindの制約内で一貫したデザインシステム
- **アクセシビリティ**: 色のみに依存しない情報伝達
- **レスポンシブ**: モバイルファーストの縦並びレイアウト

---

## カラーパレット

提案したデザインテーマをTailwindの標準カラーにマッピングします。

### プライマリカラー（メインカラー）

**用途**: ボタン、アクション要素、重要な情報のハイライト

| 色 | Tailwind クラス | 用途 |
|---|---|---|
| Orange-400 | `bg-orange-400` `text-orange-400` `border-orange-400` | 通常状態 |
| Orange-500 | `bg-orange-500` `text-orange-500` `border-orange-500` | ホバー・アクティブ状態 |
| Orange-50 | `bg-orange-50` | 背景（淡色） |

### セカンダリカラー

**用途**: セカンダリボタン、アクセント、カテゴリー分け

| 色 | Tailwind クラス | 用途 |
|---|---|---|
| Amber-300 | `bg-amber-300` `text-amber-300` `border-amber-300` | 通常状態 |
| Amber-400 | `bg-amber-400` `text-amber-400` `border-amber-400` | ホバー・アクティブ状態 |
| Amber-50 | `bg-amber-50` | 背景（淡色） |

### アクセントカラー

**用途**: チェックマーク、完了状態、リンク、成功メッセージ

| 色 | Tailwind クラス | 用途 |
|---|---|---|
| Teal-400 | `bg-teal-400` `text-teal-400` `border-teal-400` | 通常状態 |
| Teal-500 | `bg-teal-500` `text-teal-500` `border-teal-500` | ホバー・アクティブ状態 |
| Teal-50 | `bg-teal-50` | 背景（淡色） |

### ベースカラー

**用途**: 背景、テキスト、ボーダー

| 色 | Tailwind クラス | 用途 |
|---|---|---|
| Orange-50 | `bg-orange-50` | ページ全体の背景 |
| White | `bg-white` | カード、フォーム要素の背景 |
| Stone-800 | `text-stone-800` | 本文テキスト |
| Stone-600 | `text-stone-600` | 補助テキスト |
| Gray-200 | `border-gray-200` | ボーダー |

### 状態カラー

| 状態 | Tailwind クラス | 用途 |
|---|---|---|
| エラー | `bg-red-500` `text-red-500` | エラーメッセージ、削除ボタン |
| 警告 | `bg-yellow-500` `text-yellow-500` | 警告メッセージ |
| 成功 | `bg-teal-500` `text-teal-500` | 成功メッセージ |
| 情報 | `bg-blue-500` `text-blue-500` | 情報メッセージ |

---

## タイポグラフィ

### フォントサイズ

| 用途 | Tailwind クラス | サイズ | 備考 |
|---|---|---|---|
| 大見出し (H1) | `text-2xl` `font-bold` | 24px | ページタイトル |
| 中見出し (H2) | `text-xl` `font-semibold` | 20px | セクションタイトル |
| 小見出し (H3) | `text-lg` `font-semibold` | 18px | カードタイトル |
| 本文 | `text-base` | 16px | 標準テキスト |
| 小テキスト | `text-sm` | 14px | 補助情報、ラベル |
| 極小テキスト | `text-xs` | 12px | タイムスタンプ、注釈 |

### フォントウェイト

| 用途 | Tailwind クラス | ウェイト |
|---|---|---|
| 見出し | `font-bold` | 700 |
| 強調 | `font-semibold` | 600 |
| 通常 | `font-normal` | 400 |

### 行間

| 用途 | Tailwind クラス | 備考 |
|---|---|---|
| 見出し | `leading-tight` | 1.25 |
| 本文 | `leading-normal` | 1.5 |
| 長文 | `leading-relaxed` | 1.625 |

---

## スペーシング（余白）

### コンポーネント内の余白

| 用途 | Tailwind クラス | サイズ |
|---|---|---|
| 極小 | `p-1` `m-1` | 4px |
| 小 | `p-2` `m-2` | 8px |
| 中 | `p-4` `m-4` | 16px |
| 大 | `p-6` `m-6` | 24px |
| 特大 | `p-8` `m-8` | 32px |

### 要素間の余白

| 用途 | Tailwind クラス | 推奨サイズ |
|---|---|---|
| 要素間（縦） | `space-y-4` | 16px |
| 要素間（横） | `space-x-4` | 16px |
| セクション間 | `mb-6` `mt-6` | 24px |

### レイアウト

| 用途 | Tailwind クラス | 備考 |
|---|---|---|
| コンテナ余白 | `px-4` `py-4` | モバイル標準 |
| カード内余白 | `p-4` | カード内のコンテンツ |
| フォーム要素余白 | `px-4` `py-3` | 入力フィールド内 |

---

## ボーダー・角丸

### 角丸（Border Radius）

| 用途 | Tailwind クラス | サイズ | 適用対象 |
|---|---|---|---|
| 小 | `rounded` | 4px | 小さいボタン、バッジ |
| 中 | `rounded-lg` | 8px | ボタン、入力フィールド |
| 大 | `rounded-xl` | 12px | カード |
| 円形 | `rounded-full` | 50% | アバター、FAB |

### ボーダー

| 用途 | Tailwind クラス | 備考 |
|---|---|---|
| 標準 | `border` `border-gray-200` | 1px, グレー |
| 太め | `border-2` `border-gray-300` | 2px, フォーカス時 |
| フォーカス（Primary） | `border-2` `border-orange-400` | アクティブな入力フィールド |

---

## シャドウ

| 用途 | Tailwind クラス | 備考 |
|---|---|---|
| 軽いシャドウ | `shadow-sm` | カード、ボタン |
| 標準シャドウ | `shadow` | 浮遊感のあるカード |
| 中程度シャドウ | `shadow-md` | モーダル、ドロップダウン |
| 強いシャドウ | `shadow-lg` | FAB、重要なコンポーネント |

---

## コンポーネント定義

### ボタン

#### プライマリボタン

```html
<!-- 通常サイズ -->
<button class="bg-orange-400 hover:bg-orange-500 text-white font-semibold px-6 py-3 rounded-lg shadow-sm transition duration-200 active:scale-95">
  ボタン
</button>

<!-- 小サイズ -->
<button class="bg-orange-400 hover:bg-orange-500 text-white font-semibold px-4 py-2 rounded-lg shadow-sm transition duration-200 active:scale-95 text-sm">
  ボタン
</button>
```

#### セカンダリボタン

```html
<button class="bg-white hover:bg-orange-50 text-orange-500 font-semibold px-6 py-3 rounded-lg border-2 border-orange-400 transition duration-200">
  ボタン
</button>
```

#### テキストボタン

```html
<button class="text-orange-500 hover:text-orange-600 font-semibold px-4 py-2 transition duration-200">
  テキストボタン
</button>
```

#### 削除ボタン

```html
<button class="text-red-500 hover:bg-red-50 font-semibold px-4 py-2 rounded-lg transition duration-200">
  削除
</button>
```

---

### 入力フィールド

#### テキスト入力

```html
<input
  type="text"
  class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:outline-none focus:border-orange-400 focus:ring-4 focus:ring-orange-100 transition duration-200 text-base"
  placeholder="入力してください"
>
```

#### テキストエリア

```html
<textarea
  class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:outline-none focus:border-orange-400 focus:ring-4 focus:ring-orange-100 transition duration-200 text-base resize-none"
  rows="4"
  placeholder="入力してください"
></textarea>
```

#### セレクトボックス

```html
<select class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:outline-none focus:border-orange-400 focus:ring-4 focus:ring-orange-100 transition duration-200 text-base bg-white">
  <option>選択してください</option>
  <option>オプション1</option>
  <option>オプション2</option>
</select>
```

---

### カード

#### 基本カード

```html
<div class="bg-white rounded-xl shadow-sm p-4">
  <h3 class="text-lg font-semibold text-stone-800 mb-2">カードタイトル</h3>
  <p class="text-base text-stone-600">カードの内容がここに入ります。</p>
</div>
```

#### ホバー可能なカード

```html
<div class="bg-white rounded-xl shadow-sm p-4 hover:shadow-md transition duration-200 cursor-pointer">
  <h3 class="text-lg font-semibold text-stone-800 mb-2">カードタイトル</h3>
  <p class="text-base text-stone-600">カードの内容がここに入ります。</p>
</div>
```

---

### リスト

#### リストアイテム

```html
<ul class="bg-white rounded-xl shadow-sm overflow-hidden divide-y divide-gray-200">
  <li class="px-4 py-4 hover:bg-orange-50 transition duration-200 flex items-center gap-3">
    <span class="text-base text-stone-800">リストアイテム 1</span>
  </li>
  <li class="px-4 py-4 hover:bg-orange-50 transition duration-200 flex items-center gap-3">
    <span class="text-base text-stone-800">リストアイテム 2</span>
  </li>
</ul>
```

---

### チェックボックス

```html
<label class="flex items-center gap-3 cursor-pointer">
  <input
    type="checkbox"
    class="w-6 h-6 text-teal-500 bg-white border-2 border-gray-300 rounded focus:ring-4 focus:ring-teal-100 transition duration-200"
  >
  <span class="text-base text-stone-800">チェックボックス</span>
</label>
```

---

### バッジ

#### カテゴリーバッジ

```html
<span class="inline-block px-3 py-1 bg-amber-100 text-amber-800 text-xs font-semibold rounded-full">
  カテゴリー
</span>
```

#### カウントバッジ

```html
<span class="inline-flex items-center justify-center px-3 py-1 bg-amber-300 text-stone-800 text-sm font-bold rounded-full">
  5
</span>
```

---

### モーダル・オーバーレイ

```html
<!-- オーバーレイ -->
<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
  <!-- モーダル -->
  <div class="bg-white rounded-xl shadow-lg max-w-md w-full p-6">
    <h2 class="text-xl font-semibold text-stone-800 mb-4">モーダルタイトル</h2>
    <p class="text-base text-stone-600 mb-6">モーダルの内容がここに入ります。</p>
    <div class="flex gap-3">
      <button class="flex-1 bg-orange-400 hover:bg-orange-500 text-white font-semibold px-6 py-3 rounded-lg transition duration-200">
        確認
      </button>
      <button class="flex-1 bg-white hover:bg-gray-50 text-stone-600 font-semibold px-6 py-3 rounded-lg border-2 border-gray-200 transition duration-200">
        キャンセル
      </button>
    </div>
  </div>
</div>
```

---

### ヘッダー

```html
<header class="bg-gradient-to-r from-orange-400 to-orange-500 text-white shadow-sm sticky top-0 z-40">
  <div class="px-4 py-4 flex items-center justify-between max-w-2xl mx-auto">
    <h1 class="text-xl font-bold flex items-center gap-2">
      🛒 買い物リスト
    </h1>
    <button class="p-2">
      <!-- メニューアイコン -->
    </button>
  </div>
</header>
```

---

### フローティングアクションボタン（FAB）

```html
<button class="fixed bottom-6 right-6 w-14 h-14 bg-orange-400 hover:bg-orange-500 text-white rounded-full shadow-lg hover:shadow-xl transition duration-200 active:scale-95 flex items-center justify-center text-2xl z-50">
  +
</button>
```

---

## レイアウト

### コンテナ

```html
<div class="max-w-2xl mx-auto px-4 py-4">
  <!-- コンテンツ -->
</div>
```

### グリッド（タブレット以上で2カラム）

```html
<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
  <div class="bg-white rounded-xl shadow-sm p-4">カラム1</div>
  <div class="bg-white rounded-xl shadow-sm p-4">カラム2</div>
</div>
```

### Flexレイアウト

```html
<!-- 横並び（中央揃え） -->
<div class="flex items-center justify-center gap-4">
  <div>アイテム1</div>
  <div>アイテム2</div>
</div>

<!-- 横並び（左右配置） -->
<div class="flex items-center justify-between gap-4">
  <div>左</div>
  <div>右</div>
</div>

<!-- 縦並び -->
<div class="flex flex-col gap-4">
  <div>アイテム1</div>
  <div>アイテム2</div>
</div>
```

---

## アニメーション・トランジション

### 基本トランジション

すべてのインタラクティブ要素に適用：

```html
class="transition duration-200"
```

### ホバーエフェクト

```html
<!-- 背景色変更 -->
class="hover:bg-orange-50 transition duration-200"

<!-- スケール -->
class="hover:scale-105 transition duration-200"

<!-- シャドウ -->
class="hover:shadow-md transition duration-200"
```

### アクティブエフェクト

```html
<!-- ボタン押下時 -->
class="active:scale-95 transition duration-200"
```

---

## アクセシビリティ

### フォーカス状態

すべてのインタラクティブ要素にフォーカスリングを適用：

```html
<!-- 入力フィールド -->
class="focus:outline-none focus:ring-4 focus:ring-orange-100 focus:border-orange-400"

<!-- ボタン -->
class="focus:outline-none focus:ring-4 focus:ring-orange-100"
```

### タップターゲットサイズ

- **最小サイズ**: 44x44px（iOS推奨）
- **ボタン**: `px-6 py-3`（最小）
- **アイコンボタン**: `w-11 h-11`（44px）

### カラーコントラスト

- **本文テキスト**: `text-stone-800`（背景白に対して十分なコントラスト）
- **補助テキスト**: `text-stone-600`（WCAG AA基準準拠）

---

## レスポンシブデザイン

### ブレークポイント

| デバイス | Tailwind 接頭辞 | サイズ |
|---|---|---|
| モバイル | （デフォルト） | 0px〜 |
| タブレット | `md:` | 768px〜 |
| デスクトップ | `lg:` | 1024px〜 |

### 基本方針

- **モバイルファースト**: デフォルトはモバイル向けスタイル
- **縦並びレイアウト**: 基本は`flex flex-col`
- **タブレット以上で横並び**: `md:flex-row`

### 例

```html
<!-- モバイル: 縦並び、タブレット以上: 横並び -->
<div class="flex flex-col md:flex-row gap-4">
  <div class="flex-1">コンテンツ1</div>
  <div class="flex-1">コンテンツ2</div>
</div>

<!-- モバイル: 1カラム、タブレット以上: 2カラム -->
<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
  <div>カラム1</div>
  <div>カラム2</div>
</div>
```

---

## 状態管理

### 読み込み中

```html
<button class="bg-orange-400 text-white font-semibold px-6 py-3 rounded-lg opacity-50 cursor-not-allowed" disabled>
  読み込み中...
</button>
```

### 無効化

```html
<button class="bg-gray-300 text-gray-500 font-semibold px-6 py-3 rounded-lg cursor-not-allowed" disabled>
  無効なボタン
</button>
```

### エラー状態

```html
<input
  type="text"
  class="w-full px-4 py-3 border-2 border-red-500 rounded-lg focus:outline-none focus:ring-4 focus:ring-red-100 text-base"
>
<p class="text-red-500 text-sm mt-1">エラーメッセージ</p>
```

---

## アイコン

### 推奨アイコンライブラリ

- **Heroicons**（Tailwind開発元推奨）
- **絵文字**（軽量で親しみやすい印象）

### 使用例

```html
<!-- 絵文字 -->
<span class="text-2xl">🛒</span>

<!-- SVGアイコン -->
<svg class="w-6 h-6 text-orange-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
  <!-- パス -->
</svg>
```

---

## 実装例：買い物リストアイテム

```html
<ul class="bg-white rounded-xl shadow-sm overflow-hidden divide-y divide-gray-200">
  <li class="px-4 py-4 hover:bg-orange-50 transition duration-200 flex items-center gap-3">
    <!-- チェックボックス -->
    <input
      type="checkbox"
      class="w-6 h-6 text-teal-500 bg-white border-2 border-gray-300 rounded focus:ring-4 focus:ring-teal-100 transition duration-200"
    >

    <!-- アイテム情報 -->
    <div class="flex-1">
      <p class="text-base text-stone-800 font-medium">にんじん (3本)</p>
      <span class="inline-block mt-1 px-3 py-1 bg-amber-100 text-amber-800 text-xs font-semibold rounded-full">
        野菜・果物
      </span>
    </div>

    <!-- 削除ボタン -->
    <button class="w-9 h-9 text-red-500 hover:bg-red-50 rounded-full transition duration-200 flex items-center justify-center text-xl">
      ×
    </button>
  </li>
</ul>
```

---

## チェックリスト

新しいコンポーネントを作成する際のチェックリスト：

- [ ] カラーパレットに準拠しているか
- [ ] 適切な角丸（rounded）を適用しているか
- [ ] 十分な余白（padding/margin）を確保しているか
- [ ] ホバー・フォーカス状態を定義しているか
- [ ] トランジションを適用しているか
- [ ] タップターゲットサイズは44px以上か
- [ ] レスポンシブ対応しているか（モバイルファースト）
- [ ] アクセシビリティ（フォーカスリング、コントラスト）を考慮しているか

---

## 参考リンク

- [Tailwind CSS 公式ドキュメント](https://tailwindcss.com/docs)
- [Tailwind CSS カラーパレット](https://tailwindcss.com/docs/customizing-colors)
- [Heroicons](https://heroicons.com/)
- [WCAG コントラスト比](https://webaim.org/resources/contrastchecker/)

---

**最終更新**: 2025-10-18
