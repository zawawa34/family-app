import { Controller } from "@hotwired/stimulus"

// Clipboard controller
// クリップボードへのコピー機能を提供
export default class extends Controller {
  static values = {
    content: String
  }

  // コピーボタンがクリックされた時の処理
  copy(event) {
    event.preventDefault()

    const content = this.contentValue

    // Clipboard APIを使用してコピー
    navigator.clipboard.writeText(content).then(() => {
      // 成功時のフィードバック表示
      this.showFeedback(event.currentTarget)
    }).catch(err => {
      // エラー時の処理
      console.error('クリップボードへのコピーに失敗しました:', err)
      // フォールバック: テキストエリアを使用した古い方法
      this.fallbackCopy(content, event.currentTarget)
    })
  }

  // 成功フィードバックを表示
  showFeedback(button) {
    const originalText = button.innerHTML
    const originalClasses = button.className

    // ボタンのテキストとスタイルを変更
    button.innerHTML = `
      <svg class="w-5 h-5 inline-block" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
      </svg>
      コピーしました！
    `
    button.className = button.className.replace('bg-teal-500', 'bg-teal-600')
                                       .replace('hover:bg-teal-600', 'hover:bg-teal-700')

    // 2秒後に元に戻す
    setTimeout(() => {
      button.innerHTML = originalText
      button.className = originalClasses
    }, 2000)
  }

  // フォールバック: 古いブラウザ向けのコピー方法
  fallbackCopy(content, button) {
    const textArea = document.createElement('textarea')
    textArea.value = content
    textArea.style.position = 'fixed'
    textArea.style.left = '-999999px'
    document.body.appendChild(textArea)
    textArea.select()

    try {
      document.execCommand('copy')
      this.showFeedback(button)
    } catch (err) {
      console.error('フォールバックコピーにも失敗しました:', err)
      alert('クリップボードへのコピーに失敗しました')
    }

    document.body.removeChild(textArea)
  }
}
