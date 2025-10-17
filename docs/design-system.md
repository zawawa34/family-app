# デザインシステム

## 概要

本ドキュメントは、Apple Human Interface Guidelinesの原則に基づいた、家族向けアプリケーションの包括的なデザインシステムを定義します。Tailwind CSSのデフォルトクラスのみを使用し、美しく機能的なUIを実現します。

---

## デザイン哲学

### Appleの3つの原則

1. **Clarity（明確さ）**
   - テキストは読みやすく、アイコンは明確で、装飾は控えめに
   - 機能を直感的に理解できるインターフェース

2. **Deference（控えめさ）**
   - コンテンツが主役、UIは脇役
   - 滑らかなアニメーションと適切な余白でコンテンツを引き立てる

3. **Depth（奥行き）**
   - 視覚的な階層とモーションで、情報の関係性を明確に
   - シャドウとレイヤリングで奥行きを表現

### プロジェクト固有の価値

- **温かみ**: 家族が安心して使える親しみやすいデザイン
- **効率性**: 日常の家事の合間でもストレスなく操作できる
- **包括性**: 幅広い年齢層が使いやすいアクセシブルなUI

---

## カラーシステム

### カラー階層の原則

Appleの推奨に従い、明確な視覚的階層を持つカラーシステムを構築します。

#### プライマリカラー（ブランドカラー）

**Orange系統** - 温かみと活動性を表現

| レベル | Tailwind | Hex | 用途 |
|---|---|---|---|
| Light | `orange-300` | #FDB762 | ホバー背景 |
| Base | `orange-400` | #FB923C | メインアクション |
| Dark | `orange-500` | #F97316 | プレス状態 |
| Deeper | `orange-600` | #EA580C | 強調要素 |

**使用ガイドライン**:
- プライマリアクションボタン
- アクティブ状態の表示
- 重要な情報のハイライト
- ブランドを想起させる要素

#### セカンダリカラー

**Amber系統** - 柔らかさと安心感を表現

| レベル | Tailwind | Hex | 用途 |
|---|---|---|---|
| Lightest | `amber-50` | #FFFBEB | 淡い背景 |
| Light | `amber-100` | #FEF3C7 | バッジ背景 |
| Base | `amber-300` | #FCD34D | セカンダリアクション |
| Dark | `amber-400` | #FBBF24 | ホバー状態 |

**使用ガイドライン**:
- セカンダリボタン
- カテゴリーバッジ
- 情報の区別
- アクセント要素

#### アクセントカラー

**Teal系統** - 完了・成功を表現

| レベル | Tailwind | Hex | 用途 |
|---|---|---|---|
| Lightest | `teal-50` | #F0FDFA | 成功メッセージ背景 |
| Light | `teal-100` | #CCFBF1 | フォーカスリング |
| Base | `teal-400` | #2DD4BF | チェックマーク |
| Dark | `teal-500` | #14B8A6 | アクティブリンク |

**使用ガイドライン**:
- チェックボックス
- 完了状態
- リンク
- 成功フィードバック

#### ニュートラルカラー（基本色）

**Stone系統** - 読みやすさと落ち着きを表現

| レベル | Tailwind | Hex | 用途 | コントラスト比 |
|---|---|---|---|---|
| `stone-50` | #FAFAF9 | 背景（淡） | - |
| `stone-100` | #F5F5F4 | カード背景 | - |
| `stone-200` | #E7E5E4 | ボーダー | - |
| `stone-300` | #D6D3D1 | 無効状態 | - |
| `stone-400` | #A8A29E | プレースホルダー | 3.5:1 |
| `stone-500` | #78716C | 補助テキスト | 4.6:1 |
| `stone-600` | #57534E | セカンダリテキスト | 7.0:1 |
| `stone-700` | #44403C | 本文テキスト | 10.5:1 |
| `stone-800` | #292524 | 見出し | 14.5:1 |
| `stone-900` | #1C1917 | 強調テキスト | 16.5:1 |

**使用ガイドライン**:
- テキストの階層表現
- 背景とボーダー
- 無効状態の表示

#### セマンティックカラー（状態表現）

| 状態 | Tailwind | 用途 | 組み合わせ |
|---|---|---|---|
| Success | `teal-500` | 成功メッセージ | 背景: `teal-50` |
| Warning | `yellow-500` | 警告メッセージ | 背景: `yellow-50` |
| Error | `red-500` | エラー、削除 | 背景: `red-50` |
| Info | `blue-500` | 情報メッセージ | 背景: `blue-50` |

### カラー使用の原則

#### 1. 60-30-10ルール（Appleの推奨）

```
60% - ニュートラルカラー（背景、余白）
30% - プライマリカラー（主要アクション）
10% - アクセントカラー（強調、状態表示）
```

#### 2. コントラスト比（WCAG準拠）

| 要素 | 最小コントラスト比 | Tailwindクラス例 |
|---|---|---|
| 本文テキスト（16px未満） | 4.5:1 | `text-stone-700` on white |
| 大きなテキスト（18px以上） | 3:1 | `text-stone-600` on white |
| UIコンポーネント | 3:1 | ボーダー: `border-stone-300` |

#### 3. カラーのアクセシビリティ

**色だけに依存しない情報伝達**:
```html
<!-- 良い例: アイコン + 色 -->
<button class="text-red-500 flex items-center gap-2">
  <svg class="w-5 h-5"><!-- 削除アイコン --></svg>
  削除
</button>

<!-- 悪い例: 色のみ -->
<button class="text-red-500">削除</button>
```

---

## タイポグラフィ

### タイポグラフィスケール

Appleの推奨する「8ptグリッドシステム」に基づいたスケールを採用。

#### フォントサイズ階層

| レベル | Tailwind | サイズ | 行間 | 用途 | 最小タップ領域 |
|---|---|---|---|---|---|
| Display | `text-4xl` | 36px / 2.25rem | 40px | ヒーロータイトル | - |
| Title 1 | `text-3xl` | 30px / 1.875rem | 36px | ページタイトル | - |
| Title 2 | `text-2xl` | 24px / 1.5rem | 32px | セクションタイトル | - |
| Title 3 | `text-xl` | 20px / 1.25rem | 28px | カードタイトル | - |
| Headline | `text-lg` | 18px / 1.125rem | 28px | 小見出し | - |
| Body | `text-base` | 16px / 1rem | 24px | 本文 | 44px（タップ可能） |
| Callout | `text-sm` | 14px / 0.875rem | 20px | 補助情報 | 44px（タップ可能） |
| Footnote | `text-xs` | 12px / 0.75rem | 16px | 注釈 | - |
| Caption | `text-[10px]` | 10px | 12px | タイムスタンプ | - |

#### フォントウェイト

| ウェイト | Tailwind | 数値 | 用途 |
|---|---|---|---|
| Bold | `font-bold` | 700 | 見出し、強調 |
| Semibold | `font-semibold` | 600 | サブ見出し、ボタンラベル |
| Medium | `font-medium` | 500 | アクティブ状態、ナビゲーション |
| Normal | `font-normal` | 400 | 本文、通常テキスト |
| Light | `font-light` | 300 | 大きな見出し（Display） |

#### 行間（Line Height）

Appleの推奨する「テキストの可読性向上」に基づく設定:

| 用途 | Tailwind | 倍率 | 適用例 |
|---|---|---|---|
| 見出し | `leading-tight` | 1.25 | タイトル、短い文 |
| 本文 | `leading-normal` | 1.5 | 通常の段落 |
| 長文 | `leading-relaxed` | 1.625 | 長い説明文 |
| 余裕のある表示 | `leading-loose` | 2 | 入力フィールド内テキスト |

#### 文字間隔（Letter Spacing）

| 用途 | Tailwind | 値 | 適用例 |
|---|---|---|---|
| タイトル | `tracking-tight` | -0.05em | 大きな見出し |
| 通常 | `tracking-normal` | 0em | 本文 |
| キャプション | `tracking-wide` | 0.025em | 小さい注釈文字 |

### タイポグラフィの使用例

#### 見出しの階層

```html
<!-- Display: ランディングページのヒーロー -->
<h1 class="text-4xl font-bold text-stone-900 leading-tight">
  家族みんなの買い物リスト
</h1>

<!-- Title 1: ページタイトル -->
<h1 class="text-3xl font-bold text-stone-900 leading-tight">
  今日の買い物
</h1>

<!-- Title 2: セクションタイトル -->
<h2 class="text-2xl font-semibold text-stone-800 leading-tight">
  野菜・果物
</h2>

<!-- Title 3: カードタイトル -->
<h3 class="text-xl font-semibold text-stone-800 leading-tight">
  買い物リスト
</h3>

<!-- Headline: 小見出し -->
<h4 class="text-lg font-medium text-stone-700">
  今週の献立
</h4>
```

#### 本文と補助テキスト

```html
<!-- Body: 標準本文 -->
<p class="text-base text-stone-700 leading-normal">
  家族みんなで買い物リストを共有して、効率的にお買い物を楽しみましょう。
</p>

<!-- Callout: 補助情報 -->
<p class="text-sm text-stone-600 leading-normal">
  最終更新: 2時間前
</p>

<!-- Footnote: 注釈 -->
<p class="text-xs text-stone-500">
  ※ リストは自動的に保存されます
</p>
```

### タイポグラフィの原則

#### 1. 視覚的階層の明確化

```html
<!-- 適切な階層 -->
<article class="space-y-4">
  <h2 class="text-2xl font-bold text-stone-900">タイトル</h2>
  <h3 class="text-lg font-semibold text-stone-800">サブタイトル</h3>
  <p class="text-base text-stone-700">本文テキスト</p>
  <p class="text-sm text-stone-600">補助情報</p>
</article>
```

#### 2. 最大行長（Optimal Line Length）

Appleの推奨: **1行あたり50〜75文字**（日本語の場合は30〜40文字）

```html
<!-- 最大幅を制限 -->
<p class="text-base text-stone-700 leading-relaxed max-w-prose">
  長い文章の可読性を高めるため、最大幅を適切に制限します。
</p>
```

#### 3. テキスト揃え

```html
<!-- 左揃え（基本） -->
<p class="text-left">標準的なテキスト</p>

<!-- 中央揃え（見出し、短い文） -->
<h2 class="text-center">タイトル</h2>

<!-- 右揃え（数値、日付） -->
<span class="text-right">¥1,200</span>

<!-- 均等割付は避ける（可読性低下） -->
```

---

## 余白・間隔（Spacing）

### 8ptグリッドシステム

Appleが推奨する**8の倍数**を基本単位とした余白システム。

#### スペーシングスケール

| 名称 | Tailwind | サイズ | 用途 |
|---|---|---|---|
| 0 | `0` | 0px | 余白なし |
| 0.5 | `0.5` | 2px | 極小のギャップ |
| 1 | `1` | 4px | 密接な要素間 |
| 2 | `2` | 8px | 最小単位 |
| 3 | `3` | 12px | 小さな余白 |
| 4 | `4` | 16px | **標準単位** |
| 5 | `5` | 20px | やや広い余白 |
| 6 | `6` | 24px | セクション内の余白 |
| 8 | `8` | 32px | セクション間 |
| 10 | `10` | 40px | 大きな区切り |
| 12 | `12` | 48px | ページセクション間 |
| 16 | `16` | 64px | 主要セクション間 |

### コンポーネント別の余白ガイドライン

#### ボタン

```html
<!-- プライマリボタン -->
<button class="px-6 py-3">
  <!-- 横: 24px, 縦: 12px -->
  標準ボタン
</button>

<!-- 小サイズボタン -->
<button class="px-4 py-2">
  <!-- 横: 16px, 縦: 8px -->
  小ボタン
</button>

<!-- 大サイズボタン -->
<button class="px-8 py-4">
  <!-- 横: 32px, 縦: 16px -->
  大ボタン
</button>
```

#### カード

```html
<!-- 標準カード -->
<div class="p-6">
  <!-- 内側: 24px -->
</div>

<!-- コンパクトカード -->
<div class="p-4">
  <!-- 内側: 16px -->
</div>

<!-- カード間の余白 -->
<div class="space-y-4">
  <!-- 16px間隔 -->
</div>
```

#### リスト

```html
<!-- リストアイテム -->
<li class="px-4 py-3">
  <!-- 横: 16px, 縦: 12px -->
</li>

<!-- リストアイテム間 -->
<ul class="divide-y divide-stone-200">
  <!-- ボーダーで区切り、余白なし -->
</ul>

<!-- セクション化されたリスト -->
<ul class="space-y-2">
  <!-- 8px間隔 -->
</ul>
```

#### フォーム

```html
<!-- 入力フィールド -->
<input class="px-4 py-3">
  <!-- 横: 16px, 縦: 12px -->
</input>

<!-- フォーム要素間 -->
<form class="space-y-4">
  <!-- 16px間隔 -->
</form>

<!-- ラベルと入力フィールド -->
<div class="space-y-2">
  <!-- 8px間隔 -->
  <label>ラベル</label>
  <input>
</div>
```

### コンテナとレイアウト

```html
<!-- ページコンテナ -->
<div class="max-w-2xl mx-auto px-4 py-6">
  <!-- 横: 16px, 縦: 24px -->
</div>

<!-- セクション間 -->
<section class="mb-8">
  <!-- 32px余白 -->
</section>

<!-- カラム間のギャップ -->
<div class="grid grid-cols-2 gap-4">
  <!-- 16px間隔 -->
</div>
```

### 余白の原則

#### 1. 一貫性の維持

```html
<!-- 良い例: 統一された余白 -->
<div class="space-y-4">
  <div class="p-4">...</div>
  <div class="p-4">...</div>
</div>

<!-- 悪い例: バラバラの余白 -->
<div class="space-y-3">
  <div class="p-5">...</div>
  <div class="p-3">...</div>
</div>
```

#### 2. 視覚的グルーピング

**近接の原則**: 関連する要素は近く、異なるグループは遠く

```html
<article class="space-y-6">
  <!-- グループ1 -->
  <div class="space-y-2">
    <h3>タイトル</h3>
    <p>説明文</p>
  </div>

  <!-- グループ2（大きな余白で区切る） -->
  <div class="space-y-2">
    <h3>タイトル</h3>
    <p>説明文</p>
  </div>
</article>
```

#### 3. レスポンシブな余白

```html
<!-- モバイル: 小さめ、デスクトップ: 大きめ -->
<div class="p-4 md:p-6 lg:p-8">
  コンテンツ
</div>

<!-- セクション間の余白 -->
<section class="mb-8 md:mb-12 lg:mb-16">
  セクション
</section>
```

---

## 角丸（Border Radius）

### 角丸スケール

Appleの「Soft Corners」原則に基づく、温かみのある角丸設計。

| 名称 | Tailwind | サイズ | 用途 |
|---|---|---|---|
| None | `rounded-none` | 0px | 境界線なし、エッジの効いたデザイン |
| Small | `rounded` | 4px | 小さいボタン、バッジ |
| Medium | `rounded-lg` | 8px | ボタン、入力フィールド |
| Large | `rounded-xl` | 12px | カード、モーダル |
| XLarge | `rounded-2xl` | 16px | 大きなカード、画像 |
| Full | `rounded-full` | 9999px | 円形（アバター、FAB） |

### コンポーネント別の角丸ガイドライン

#### ボタン

```html
<!-- 標準ボタン -->
<button class="rounded-lg">
  <!-- 8px -->
</button>

<!-- ピルボタン（両端が丸い） -->
<button class="rounded-full">
  <!-- 完全な円形 -->
</button>
```

#### カード

```html
<!-- 標準カード -->
<div class="rounded-xl">
  <!-- 12px -->
</div>

<!-- 大きなカード -->
<div class="rounded-2xl">
  <!-- 16px -->
</div>
```

#### 入力フィールド

```html
<!-- 標準入力 -->
<input class="rounded-lg">
  <!-- 8px -->
</input>

<!-- 検索フィールド（両端が丸い） -->
<input class="rounded-full">
  <!-- 完全な円形 -->
</input>
```

#### バッジ

```html
<!-- 角丸バッジ -->
<span class="rounded-full px-3 py-1">
  <!-- 完全な円形 -->
</span>

<!-- 小さなバッジ -->
<span class="rounded px-2 py-0.5">
  <!-- 4px -->
</span>
```

#### 画像とアバター

```html
<!-- 角丸画像 -->
<img class="rounded-xl">
  <!-- 12px -->
</img>

<!-- 円形アバター -->
<img class="rounded-full">
  <!-- 完全な円形 -->
</img>
```

### 角丸の組み合わせ

#### 片側のみ角丸

```html
<!-- 上側のみ -->
<div class="rounded-t-xl">上部角丸</div>

<!-- 下側のみ -->
<div class="rounded-b-xl">下部角丸</div>

<!-- 左側のみ -->
<div class="rounded-l-xl">左側角丸</div>

<!-- 右側のみ -->
<div class="rounded-r-xl">右側角丸</div>
```

#### 角ごとに指定

```html
<!-- 左上のみ -->
<div class="rounded-tl-xl">左上角丸</div>

<!-- 右上のみ -->
<div class="rounded-tr-xl">右上角丸</div>

<!-- 左下のみ -->
<div class="rounded-bl-xl">左下角丸</div>

<!-- 右下のみ -->
<div class="rounded-br-xl">右下角丸</div>
```

### 角丸の原則

#### 1. 一貫性のある階層

```
大きな要素（カード） > 中程度の要素（ボタン） > 小さな要素（バッジ）
rounded-xl (12px)    > rounded-lg (8px)        > rounded (4px)
```

#### 2. ネストされた角丸

親要素と子要素の角丸を調和させる:

```html
<!-- 親: 12px, 子: 8px -->
<div class="rounded-xl p-4">
  <button class="rounded-lg">ボタン</button>
</div>
```

---

## 影の効果（Shadow）

### シャドウスケール

Appleの「Depth（奥行き）」原則に基づく、立体感の表現。

| レベル | Tailwind | Y軸オフセット | ぼかし | 透明度 | 用途 |
|---|---|---|---|---|---|
| 0 | `shadow-none` | - | - | - | フラット |
| 1 | `shadow-sm` | 1px | 2px | 5% | 微妙な浮遊感 |
| 2 | `shadow` | 1px | 3px | 10% | カード |
| 3 | `shadow-md` | 4px | 6px | 7% | ホバー状態 |
| 4 | `shadow-lg` | 10px | 15px | 10% | モーダル |
| 5 | `shadow-xl` | 20px | 25px | 10% | FAB、ドロップダウン |
| 6 | `shadow-2xl` | 25px | 50px | 12% | ドラッグ中の要素 |

### コンポーネント別のシャドウガイドライン

#### カード

```html
<!-- 静止状態 -->
<div class="shadow-sm">標準カード</div>

<!-- ホバー状態 -->
<div class="shadow-sm hover:shadow-md transition-shadow duration-200">
  ホバー可能なカード
</div>

<!-- 選択状態 -->
<div class="shadow-lg">選択されたカード</div>
```

#### ボタン

```html
<!-- 標準ボタン（シャドウなし or 極小） -->
<button class="shadow-sm">ボタン</button>

<!-- フローティングボタン -->
<button class="shadow-lg">FAB</button>

<!-- ホバー時に浮き上がる -->
<button class="shadow hover:shadow-md transition-shadow duration-200">
  ホバーボタン
</button>
```

#### モーダルとドロップダウン

```html
<!-- モーダル -->
<div class="shadow-xl">モーダル</div>

<!-- ドロップダウンメニュー -->
<div class="shadow-lg">ドロップダウン</div>

<!-- ツールチップ -->
<div class="shadow-md">ツールチップ</div>
```

### シャドウの状態遷移

#### ホバー効果

```html
<div class="shadow-sm hover:shadow-md transition-shadow duration-200">
  ホバーで浮き上がる
</div>
```

#### アクティブ効果

```html
<button class="shadow-md active:shadow-sm transition-shadow duration-100">
  押下時に沈む
</button>
```

#### ドラッグ効果

```html
<div class="shadow-md" data-dragging="shadow-2xl">
  ドラッグ可能な要素
</div>
```

### シャドウの原則

#### 1. 階層の表現

```
最前面（モーダル、FAB） > 中間（ホバー状態） > 背面（静止状態）
shadow-xl              > shadow-md          > shadow-sm
```

#### 2. 控えめな使用

過度なシャドウは避け、必要な場所にのみ適用:

```html
<!-- 良い例: 主要なカードのみ -->
<div class="shadow-sm">重要なカード</div>
<div class="border border-stone-200">通常のコンテナ</div>

<!-- 悪い例: すべてにシャドウ -->
<div class="shadow-lg">...</div>
<div class="shadow-lg">...</div>
```

---

## コンポーネント設計

### ボタン

Appleの「Tap Target Size（最小44x44px）」原則を遵守。

#### プライマリボタン

```html
<button class="
  bg-orange-400 hover:bg-orange-500 active:bg-orange-600
  text-white font-semibold
  px-6 py-3 rounded-lg
  shadow-sm hover:shadow-md
  transition-all duration-200 ease-out
  active:scale-95
  focus:outline-none focus:ring-4 focus:ring-orange-200
  disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:bg-orange-400
  min-h-[44px]
">
  プライマリアクション
</button>
```

#### セカンダリボタン

```html
<button class="
  bg-white hover:bg-orange-50 active:bg-orange-100
  text-orange-500 font-semibold
  px-6 py-3 rounded-lg
  border-2 border-orange-400
  transition-all duration-200 ease-out
  active:scale-95
  focus:outline-none focus:ring-4 focus:ring-orange-200
  min-h-[44px]
">
  セカンダリアクション
</button>
```

#### テキストボタン

```html
<button class="
  text-orange-500 hover:text-orange-600 active:text-orange-700
  font-semibold
  px-4 py-2 rounded-lg
  hover:bg-orange-50
  transition-all duration-200 ease-out
  focus:outline-none focus:ring-4 focus:ring-orange-200
  min-h-[44px]
">
  テキストボタン
</button>
```

#### 削除ボタン

```html
<button class="
  bg-red-500 hover:bg-red-600 active:bg-red-700
  text-white font-semibold
  px-6 py-3 rounded-lg
  shadow-sm hover:shadow-md
  transition-all duration-200 ease-out
  active:scale-95
  focus:outline-none focus:ring-4 focus:ring-red-200
  min-h-[44px]
">
  削除
</button>
```

#### アイコンボタン

```html
<button class="
  w-11 h-11
  flex items-center justify-center
  text-stone-600 hover:text-stone-800
  hover:bg-stone-100 active:bg-stone-200
  rounded-full
  transition-all duration-200 ease-out
  focus:outline-none focus:ring-4 focus:ring-stone-200
">
  <svg class="w-6 h-6"><!-- アイコン --></svg>
</button>
```

### カード

#### 基本カード

```html
<div class="
  bg-white rounded-xl
  shadow-sm hover:shadow-md
  transition-shadow duration-200
  p-6
  border border-stone-100
">
  <h3 class="text-xl font-semibold text-stone-800 mb-2">カードタイトル</h3>
  <p class="text-base text-stone-600 leading-normal">カードの内容</p>
</div>
```

#### クリッカブルカード

```html
<button class="
  w-full text-left
  bg-white rounded-xl
  shadow-sm hover:shadow-md active:shadow-sm
  transition-all duration-200
  p-6
  border border-stone-100
  focus:outline-none focus:ring-4 focus:ring-orange-200
  active:scale-[0.98]
">
  <h3 class="text-xl font-semibold text-stone-800 mb-2">クリック可能なカード</h3>
  <p class="text-base text-stone-600 leading-normal">タップでアクション</p>
</button>
```

### 入力フィールド

#### テキスト入力

```html
<input
  type="text"
  class="
    w-full px-4 py-3
    text-base text-stone-800 placeholder-stone-400
    bg-white
    border-2 border-stone-200
    rounded-lg
    transition-all duration-200
    focus:outline-none focus:border-orange-400 focus:ring-4 focus:ring-orange-100
    disabled:bg-stone-100 disabled:cursor-not-allowed
    min-h-[44px]
  "
  placeholder="入力してください"
>
```

#### エラー状態

```html
<div class="space-y-2">
  <input
    type="text"
    class="
      w-full px-4 py-3
      text-base text-stone-800
      bg-white
      border-2 border-red-500
      rounded-lg
      focus:outline-none focus:ring-4 focus:ring-red-100
      min-h-[44px]
    "
  >
  <p class="text-sm text-red-500 flex items-center gap-1">
    <svg class="w-4 h-4"><!-- エラーアイコン --></svg>
    エラーメッセージ
  </p>
</div>
```

### チェックボックス

```html
<label class="flex items-center gap-3 cursor-pointer min-h-[44px] py-2">
  <input
    type="checkbox"
    class="
      w-6 h-6
      text-teal-500 bg-white
      border-2 border-stone-300
      rounded
      transition-all duration-200
      focus:ring-4 focus:ring-teal-100
      cursor-pointer
    "
  >
  <span class="text-base text-stone-800 select-none">チェックボックス</span>
</label>
```

### リスト

```html
<ul class="bg-white rounded-xl shadow-sm overflow-hidden divide-y divide-stone-200">
  <li class="
    px-4 py-3
    hover:bg-orange-50
    transition-colors duration-200
    flex items-center gap-3
    min-h-[56px]
  ">
    <span class="text-base text-stone-800">リストアイテム</span>
  </li>
</ul>
```

---

## アクセシビリティ配慮

### タッチターゲットサイズ

Appleの推奨: **最小44x44px**

```html
<!-- ボタン -->
<button class="min-h-[44px] px-6 py-3">ボタン</button>

<!-- アイコンボタン -->
<button class="w-11 h-11">アイコン</button>

<!-- チェックボックス含むラベル -->
<label class="min-h-[44px] flex items-center">
  <input type="checkbox" class="w-6 h-6">
  <span>ラベル</span>
</label>
```

### フォーカス表示

すべてのインタラクティブ要素に明確なフォーカスリングを適用:

```html
<button class="focus:outline-none focus:ring-4 focus:ring-orange-200">
  ボタン
</button>

<input class="focus:outline-none focus:border-orange-400 focus:ring-4 focus:ring-orange-100">
```

### カラーコントラスト

WCAG AA基準（4.5:1以上）を遵守:

```html
<!-- 良い例: 十分なコントラスト -->
<p class="text-stone-700">本文テキスト</p> <!-- 10.5:1 -->

<!-- 悪い例: 不十分なコントラスト -->
<p class="text-stone-300">本文テキスト</p> <!-- 2.1:1 -->
```

### セマンティックHTML

```html
<!-- 良い例: セマンティックなマークアップ -->
<button type="button">クリック</button>
<nav><a href="/">ホーム</a></nav>
<main><article>コンテンツ</article></main>

<!-- 悪い例: div/spanの乱用 -->
<div onclick="...">クリック</div>
<span>ホーム</span>
```

### ARIAラベル

```html
<!-- アイコンのみのボタン -->
<button aria-label="メニューを開く">
  <svg><!-- ハンバーガーアイコン --></svg>
</button>

<!-- 読み込み状態 -->
<button aria-busy="true" aria-label="読み込み中">
  読み込み中...
</button>

<!-- 展開可能なセクション -->
<button aria-expanded="false" aria-controls="content">
  展開
</button>
```

---

## レスポンシブデザイン

### ブレークポイント戦略

Appleの「Adaptive Layout」原則に基づく設計。

| デバイス | Tailwind接頭辞 | 幅 | デザイン方針 |
|---|---|---|---|
| モバイル（縦） | （なし） | 0-767px | 縦並びレイアウト |
| タブレット（縦） | `md:` | 768-1023px | 2カラムも検討 |
| タブレット（横）/デスクトップ | `lg:` | 1024px- | 横並びレイアウト |
| ワイドスクリーン | `xl:` | 1280px- | 最大幅制限 |

### モバイルファースト設計

```html
<!-- デフォルト: モバイル縦並び -->
<div class="flex flex-col gap-4 md:flex-row md:gap-6">
  <div class="flex-1">コンテンツ1</div>
  <div class="flex-1">コンテンツ2</div>
</div>
```

### レスポンシブタイポグラフィ

```html
<!-- サイズを段階的に拡大 -->
<h1 class="text-2xl md:text-3xl lg:text-4xl font-bold">
  タイトル
</h1>

<!-- 余白も段階的に調整 -->
<section class="py-8 md:py-12 lg:py-16">
  セクション
</section>
```

### レスポンシブグリッド

```html
<!-- モバイル: 1カラム、タブレット: 2カラム、デスクトップ: 3カラム -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  <div>アイテム1</div>
  <div>アイテム2</div>
  <div>アイテム3</div>
</div>
```

### コンテナ最大幅

```html
<!-- 読みやすさのために最大幅を制限 -->
<div class="max-w-7xl mx-auto px-4 md:px-6 lg:px-8">
  コンテンツ
</div>

<!-- コンテンツ幅の制限 -->
<article class="max-w-prose mx-auto">
  長い文章
</article>
```

---

## アニメーションとトランジション

### トランジション速度

Appleの推奨: **自然で快適な速度感**

| 用途 | Tailwind | 時間 | イージング |
|---|---|---|---|
| 即座の反応 | `duration-100` | 100ms | `ease-out` |
| 標準的な変化 | `duration-200` | 200ms | `ease-out` |
| ゆったりした変化 | `duration-300` | 300ms | `ease-in-out` |
| 劇的な変化 | `duration-500` | 500ms | `ease-in-out` |

### イージング関数

```html
<!-- 標準（デフォルト） -->
<div class="transition-all duration-200">要素</div>

<!-- ease-in-out: 滑らかな加減速 -->
<div class="transition-all duration-300 ease-in-out">要素</div>

<!-- ease-out: 素早く始まり、ゆっくり終わる -->
<div class="transition-all duration-200 ease-out">要素</div>

<!-- ease-in: ゆっくり始まり、素早く終わる -->
<div class="transition-all duration-200 ease-in">要素</div>
```

### トランジションの種類

#### 色の変化

```html
<button class="
  bg-orange-400 hover:bg-orange-500
  transition-colors duration-200
">
  ボタン
</button>
```

#### シャドウの変化

```html
<div class="
  shadow-sm hover:shadow-md
  transition-shadow duration-200
">
  カード
</div>
```

#### スケール変化

```html
<button class="
  hover:scale-105 active:scale-95
  transition-transform duration-200
">
  ボタン
</button>
```

#### すべてのプロパティ

```html
<div class="
  bg-white hover:bg-orange-50
  shadow-sm hover:shadow-md
  scale-100 hover:scale-105
  transition-all duration-200
">
  カード
</div>
```

### マイクロインタラクション

#### ボタン押下

```html
<button class="
  active:scale-95
  transition-transform duration-100 ease-out
">
  押すと縮む
</button>
```

#### ホバー浮上

```html
<div class="
  hover:-translate-y-1
  transition-transform duration-200 ease-out
">
  ホバーで浮く
</div>
```

#### フェードイン

```html
<div class="
  opacity-0 hover:opacity-100
  transition-opacity duration-300
">
  フェードイン
</div>
```

### アニメーションの原則

#### 1. 控えめで目的のある動き

```html
<!-- 良い例: 機能的なアニメーション -->
<button class="hover:scale-105 transition-transform duration-200">
  拡大でクリック可能を示唆
</button>

<!-- 悪い例: 過剰なアニメーション -->
<button class="animate-bounce hover:rotate-180 hover:scale-150">
  過剰
</button>
```

#### 2. 一貫性のある速度

プロジェクト全体で統一された速度を使用:
- 標準: `duration-200`
- ゆっくり: `duration-300`

#### 3. パフォーマンス配慮

GPU加速プロパティのみをアニメーション:
- ✅ `transform`, `opacity`
- ❌ `width`, `height`, `top`, `left`

---

## フォーム要素のデザイン

### 入力フィールドの状態

#### 通常状態

```html
<input
  type="text"
  class="
    w-full px-4 py-3
    text-base text-stone-800 placeholder-stone-400
    bg-white
    border-2 border-stone-200
    rounded-lg
    transition-all duration-200
    min-h-[44px]
  "
>
```

#### フォーカス状態

```html
<input
  class="
    focus:outline-none
    focus:border-orange-400
    focus:ring-4 focus:ring-orange-100
  "
>
```

#### エラー状態

```html
<input
  class="
    border-2 border-red-500
    focus:ring-red-100
  "
>
<p class="text-sm text-red-500 mt-1">エラーメッセージ</p>
```

#### 成功状態

```html
<input
  class="
    border-2 border-teal-500
    focus:ring-teal-100
  "
>
<p class="text-sm text-teal-600 mt-1 flex items-center gap-1">
  <svg class="w-4 h-4"><!-- チェックアイコン --></svg>
  入力が確認されました
</p>
```

#### 無効状態

```html
<input
  disabled
  class="
    bg-stone-100
    text-stone-400
    cursor-not-allowed
  "
>
```

### ラベルとヘルパーテキスト

```html
<div class="space-y-2">
  <!-- ラベル -->
  <label class="block text-sm font-semibold text-stone-700">
    メールアドレス
    <span class="text-red-500">*</span>
  </label>

  <!-- 入力フィールド -->
  <input
    type="email"
    class="w-full px-4 py-3 border-2 border-stone-200 rounded-lg"
  >

  <!-- ヘルパーテキスト -->
  <p class="text-xs text-stone-500">
    ログイン時に使用するメールアドレスを入力してください
  </p>
</div>
```

### セレクトボックス

```html
<select class="
  w-full px-4 py-3
  text-base text-stone-800
  bg-white
  border-2 border-stone-200
  rounded-lg
  transition-all duration-200
  focus:outline-none focus:border-orange-400 focus:ring-4 focus:ring-orange-100
  min-h-[44px]
  cursor-pointer
">
  <option>選択してください</option>
  <option>オプション1</option>
  <option>オプション2</option>
</select>
```

### テキストエリア

```html
<textarea
  class="
    w-full px-4 py-3
    text-base text-stone-800 placeholder-stone-400
    bg-white
    border-2 border-stone-200
    rounded-lg
    transition-all duration-200
    focus:outline-none focus:border-orange-400 focus:ring-4 focus:ring-orange-100
    resize-none
  "
  rows="4"
  placeholder="メモを入力してください"
></textarea>
```

### ラジオボタン

```html
<div class="space-y-3">
  <label class="flex items-center gap-3 cursor-pointer min-h-[44px] py-2">
    <input
      type="radio"
      name="option"
      class="
        w-5 h-5
        text-orange-500 bg-white
        border-2 border-stone-300
        focus:ring-4 focus:ring-orange-100
        cursor-pointer
      "
    >
    <span class="text-base text-stone-800 select-none">オプション1</span>
  </label>

  <label class="flex items-center gap-3 cursor-pointer min-h-[44px] py-2">
    <input
      type="radio"
      name="option"
      class="w-5 h-5 text-orange-500 border-2 border-stone-300 focus:ring-4 focus:ring-orange-100"
    >
    <span class="text-base text-stone-800 select-none">オプション2</span>
  </label>
</div>
```

### トグルスイッチ（チェックボックスでの実装）

```html
<label class="flex items-center gap-3 cursor-pointer min-h-[44px]">
  <input
    type="checkbox"
    class="
      peer
      sr-only
    "
  >
  <div class="
    relative w-11 h-6
    bg-stone-300
    rounded-full
    peer-checked:bg-teal-500
    peer-focus:ring-4 peer-focus:ring-teal-100
    transition-colors duration-200
    after:content-['']
    after:absolute after:top-0.5 after:left-0.5
    after:w-5 after:h-5
    after:bg-white after:rounded-full
    after:transition-transform after:duration-200
    peer-checked:after:translate-x-5
  "></div>
  <span class="text-base text-stone-800 select-none">通知を受け取る</span>
</label>
```

---

## グリッドシステム

### 12カラムグリッド

```html
<!-- 基本的な12カラムグリッド -->
<div class="grid grid-cols-12 gap-4">
  <div class="col-span-6">6カラム</div>
  <div class="col-span-6">6カラム</div>
</div>

<!-- 4-8分割 -->
<div class="grid grid-cols-12 gap-4">
  <div class="col-span-4">サイドバー</div>
  <div class="col-span-8">メインコンテンツ</div>
</div>
```

### レスポンシブグリッド

```html
<!-- モバイル: 1カラム、タブレット: 2カラム、デスクトップ: 3カラム -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  <div>アイテム1</div>
  <div>アイテム2</div>
  <div>アイテム3</div>
</div>

<!-- モバイル: 全幅、タブレット以上: 4-8分割 -->
<div class="grid grid-cols-1 lg:grid-cols-12 gap-4">
  <aside class="lg:col-span-4">サイドバー</aside>
  <main class="lg:col-span-8">メインコンテンツ</main>
</div>
```

### 自動フィットグリッド

```html
<!-- 最小幅を保ちながら自動的にカラム数を調整 -->
<div class="grid grid-cols-[repeat(auto-fit,minmax(250px,1fr))] gap-4">
  <div>自動調整されるアイテム</div>
  <div>自動調整されるアイテム</div>
  <div>自動調整されるアイテム</div>
</div>
```

### ギャップ（間隔）

```html
<!-- 標準ギャップ: 16px -->
<div class="grid grid-cols-3 gap-4">
  アイテム
</div>

<!-- 小さいギャップ: 8px -->
<div class="grid grid-cols-3 gap-2">
  アイテム
</div>

<!-- 大きいギャップ: 24px -->
<div class="grid grid-cols-3 gap-6">
  アイテム
</div>

<!-- 横と縦で異なるギャップ -->
<div class="grid grid-cols-3 gap-x-4 gap-y-6">
  アイテム
</div>
```

---

## 一貫性のあるデザインシステムの維持方法

### 1. デザイントークンの使用

#### カラートークン

```html
<!-- ❌ 悪い例: ハードコード -->
<button class="bg-orange-400">ボタン</button>

<!-- ✅ 良い例: 定義されたカラーを使用 -->
<button class="bg-orange-400">プライマリボタン</button>
<!-- プロジェクト全体で orange-400 = プライマリカラー -->
```

#### スペーシングトークン

```html
<!-- 標準的な余白パターン -->
カード内: p-6 (24px)
コンテナ: px-4 py-6 (横16px, 縦24px)
要素間: space-y-4 (16px)
セクション間: mb-8 (32px)
```

### 2. コンポーネントライブラリの構築

#### 再利用可能なコンポーネント

```html
<!-- プライマリボタンの標準クラス -->
class="
  bg-orange-400 hover:bg-orange-500
  text-white font-semibold
  px-6 py-3 rounded-lg
  shadow-sm hover:shadow-md
  transition-all duration-200
  focus:outline-none focus:ring-4 focus:ring-orange-200
  min-h-[44px]
"
```

#### コンポーネントの命名規則

```
.btn-primary     プライマリボタン
.btn-secondary   セカンダリボタン
.btn-text        テキストボタン
.card-standard   標準カード
.input-text      テキスト入力
```

### 3. チェックリスト

新しいコンポーネントを作成する際:

- [ ] 定義されたカラーパレットを使用しているか
- [ ] 8ptグリッドシステムに基づいた余白を使用しているか
- [ ] 適切な角丸サイズを適用しているか
- [ ] タップターゲットサイズは44px以上か
- [ ] フォーカス状態を定義しているか（focus:ring-4）
- [ ] ホバー・アクティブ状態を定義しているか
- [ ] トランジションを適用しているか（duration-200）
- [ ] レスポンシブ対応しているか（モバイルファースト）
- [ ] カラーコントラストは十分か（4.5:1以上）
- [ ] セマンティックHTMLを使用しているか
- [ ] ARIAラベルが必要な場合は追加しているか

### 4. ドキュメント化

#### コンポーネントカタログ

各コンポーネントをドキュメント化:
- 使用例
- バリエーション
- プロパティ
- アクセシビリティ考慮事項

#### デザイン決定の記録

```markdown
## なぜorange-400をプライマリカラーに選んだか

- 温かみがあり、家族向けに親しみやすい
- 食事・買い物を連想させる色
- 十分なコントラスト比を確保（白背景に対して）
```

### 5. レビュープロセス

#### デザインレビューのポイント

1. **一貫性**: 既存コンポーネントとの整合性
2. **アクセシビリティ**: WCAG基準の遵守
3. **レスポンシブ**: 各画面サイズでの表示確認
4. **パフォーマンス**: 不要なアニメーションの排除

---

## 参考資料

### Apple Design Resources

- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines)
- [SF Symbols](https://developer.apple.com/sf-symbols/)
- [Design Resources](https://developer.apple.com/design/resources/)

### アクセシビリティ

- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)

### Tailwind CSS

- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Tailwind UI Components](https://tailwindui.com/)

---

**最終更新**: 2025-10-18
**バージョン**: 1.0
