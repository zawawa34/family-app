import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// ドラッグ&ドロップによる商品の並び替えUIを提供するコントローラー
// SortableJSライブラリを使用してDOM要素をドラッグ可能にし、
// 並び替え後にサーバーに位置情報を送信する
export default class extends Controller {
  static values = {
    url: String  // 並び替えAPIのURL（個別商品のposition更新エンドポイント）
  }

  connect() {
    // SortableJSを初期化
    // リスト内のアイテムをドラッグ&ドロップで並び替え可能にする
    this.sortable = Sortable.create(this.element, {
      animation: 150,           // ドラッグ時のアニメーション時間（ミリ秒）
      handle: '.drag-handle',   // ドラッグハンドル（指定した要素をドラッグ可能に）
      ghostClass: 'opacity-50', // ドラッグ中の要素に適用されるクラス
      onEnd: this.onEnd.bind(this)  // ドロップ時のコールバック
    })
  }

  disconnect() {
    // コントローラーが破棄される際にSortableインスタンスをクリーンアップ
    if (this.sortable) {
      this.sortable.destroy()
    }
  }

  async onEnd(event) {
    // ドラッグ&ドロップ完了時に呼ばれるコールバック
    // 移動先の直前のアイテムIDを取得して、サーバーに送信

    const itemId = event.item.dataset.itemId
    const previousElement = event.item.previousElementSibling
    const afterId = previousElement?.dataset.itemId || null

    try {
      const response = await fetch(this.urlValue.replace(':item_id', itemId), {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': this.csrfToken
        },
        body: JSON.stringify({
          position: { after: afterId }
        })
      })

      if (!response.ok) {
        throw new Error('Failed to reorder')
      }
    } catch (error) {
      console.error('Reorder error:', error)
      // エラー時は元の位置に戻す
      // 一時的にdisabledにして、DOM操作が完了したら再度有効化
      this.sortable.option("disabled", true)
      window.location.reload()  // エラー時はページをリロードして元の状態に戻す
    }
  }

  // CSRFトークンを取得
  get csrfToken() {
    return document.querySelector('[name="csrf-token"]').content
  }
}
