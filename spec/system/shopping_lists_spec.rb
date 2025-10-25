require 'rails_helper'

RSpec.describe "ShoppingLists", type: :system, js: true do
  include ActionView::RecordIdentifier

  let(:user) { create(:user, :general) }
  let(:auth) { create(:database_authentication, user: user) }

  before do
    driven_by(:headless_chrome)
    # システムテストではlogin_asを使用
    login_as(auth, scope: :user_database_authentication)
  end

  describe "買い物リスト画面" do
    let!(:shopping_list) { ShoppingList.default }

    context "空の状態" do
      it "空の状態メッセージを表示すること" do
        visit shopping_lists_path

        expect(page).to have_content("買い物リストが空です")
        expect(page).to have_content("商品を追加して買い物を始めましょう")
      end
    end

    context "基本的な買い物フロー" do
      it "商品を追加して表示できること" do
        visit shopping_lists_path

        # 1. 商品を追加
        fill_in "shopping_item_name", with: "牛乳"
        click_button "追加"

        # 成功メッセージを確認
        expect(page).to have_content("「牛乳」を追加しました", wait: 5)
        # 商品が表示されることを確認
        expect(page).to have_content("牛乳")

        # 2. もう一つ商品を追加
        fill_in "shopping_item_name", with: "パン"
        click_button "追加"

        expect(page).to have_content("「パン」を追加しました", wait: 5)
        expect(page).to have_content("パン")
      end
    end

    context "セキュリティ確認" do
      it "未認証ユーザーはログイン画面にリダイレクトされること" do
        # ログアウト
        logout(:user_database_authentication)

        visit shopping_lists_path

        # ログイン画面にリダイレクトされることを確認
        expect(page).to have_current_path(new_user_database_authentication_session_path)
        expect(page).to have_content("ログイン")
      end
    end

    context "店舗フィルタリング" do
      let!(:item1) { shopping_list.items.create!(name: "牛乳", store_name: "スーパーA") }
      let!(:item2) { shopping_list.items.create!(name: "シャンプー", store_name: "ドラッグストア") }
      let!(:item3) { shopping_list.items.create!(name: "その他") } # 店舗未設定

      it "店舗でフィルタできること" do
        visit shopping_lists_path

        # すべての商品が表示されることを確認
        expect(page).to have_content("牛乳")
        expect(page).to have_content("シャンプー")
        expect(page).to have_content("その他")

        # スーパーAでフィルタ
        click_link "スーパーA"

        # スーパーAの商品と店舗未設定商品が表示される
        expect(page).to have_content("牛乳")
        expect(page).to have_content("その他")
        expect(page).not_to have_content("シャンプー")
        expect(page).to have_content("「スーパーA」でフィルタ中")

        # すべて表示に戻す
        click_link "すべて"

        expect(page).to have_content("牛乳")
        expect(page).to have_content("シャンプー")
        expect(page).to have_content("その他")
      end
    end
  end
end
