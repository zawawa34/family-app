import { Controller } from "@hotwired/stimulus"

// 店舗名のオートコンプリート機能を提供するコントローラー
export default class extends Controller {
  static targets = ["input", "results"]
  static values = {
    url: String
  }

  connect() {
    this.timeout = null
    this.minLength = 1 // 最小入力文字数
    this.debounceDelay = 300 // デバウンス遅延(ミリ秒)
  }

  disconnect() {
    this.clearTimeout()
  }

  // 入力時のイベントハンドラー
  onInput() {
    const query = this.inputTarget.value.trim()

    // 最小文字数未満の場合は結果をクリア
    if (query.length < this.minLength) {
      this.hideResults()
      return
    }

    // デバウンス: 前回のタイムアウトをクリア
    this.clearTimeout()

    // 一定時間後に検索を実行
    this.timeout = setTimeout(() => {
      this.search(query)
    }, this.debounceDelay)
  }

  // 店舗名を検索
  async search(query) {
    try {
      const url = `${this.urlValue}?q=${encodeURIComponent(query)}`
      const response = await fetch(url, {
        headers: {
          'Accept': 'application/json'
        }
      })

      if (!response.ok) {
        throw new Error('検索に失敗しました')
      }

      const stores = await response.json()
      this.showResults(stores)
    } catch (error) {
      console.error('オートコンプリートエラー:', error)
      this.hideResults()
    }
  }

  // 検索結果を表示
  showResults(stores) {
    if (stores.length === 0) {
      this.hideResults()
      return
    }

    // 結果リストを構築
    const html = stores.map(store => {
      const escapedStore = this.escapeHtml(store)
      return `
        <div class="autocomplete-item px-4 py-2 hover:bg-orange-50 cursor-pointer border-b border-stone-100 last:border-b-0"
             data-action="click->autocomplete#select"
             data-value="${escapedStore}">
          ${escapedStore}
        </div>
      `
    }).join('')

    this.resultsTarget.innerHTML = html
    this.resultsTarget.classList.remove('hidden')
  }

  // 検索結果を非表示
  hideResults() {
    this.resultsTarget.innerHTML = ''
    this.resultsTarget.classList.add('hidden')
  }

  // 店舗名を選択
  select(event) {
    const value = event.currentTarget.dataset.value
    this.inputTarget.value = value
    this.hideResults()
    this.inputTarget.focus()
  }

  // フォーカスが外れたときに結果を非表示
  // ただし、結果をクリックする時間を確保するため遅延を設ける
  onBlur() {
    setTimeout(() => {
      this.hideResults()
    }, 200)
  }

  // HTMLエスケープ
  escapeHtml(text) {
    const div = document.createElement('div')
    div.textContent = text
    return div.innerHTML
  }

  // タイムアウトをクリア
  clearTimeout() {
    if (this.timeout) {
      clearTimeout(this.timeout)
      this.timeout = null
    }
  }
}
