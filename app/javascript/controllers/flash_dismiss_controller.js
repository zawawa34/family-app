import { Controller } from "@hotwired/stimulus"

// フラッシュメッセージの自動削除コントローラー
export default class extends Controller {
  static values = {
    delay: { type: Number, default: 5000 } // デフォルト5秒後に自動削除
  }

  connect() {
    // 指定時間後に自動削除
    this.timeout = setTimeout(() => {
      this.dismiss()
    }, this.delayValue)
  }

  disconnect() {
    // タイムアウトをクリア
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }

  // メッセージを閉じる
  dismiss() {
    // フェードアウトアニメーション
    this.element.style.transition = 'opacity 300ms ease-out'
    this.element.style.opacity = '0'

    // アニメーション完了後に要素を削除
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }
}
