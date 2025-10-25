require 'rails_helper'

RSpec.describe "ShoppingLists", type: :system, js: true do
  let(:user) { create(:user, :general) }
  let(:auth) { create(:database_authentication, user: user) }

  before do
    driven_by(:headless_chrome)
    # システムテストではlogin_asを使用
    login_as(auth, scope: :user_database_authentication)
  end

  describe "買い物リスト画面" do
    let!(:shopping_list) { ShoppingList.default }

    context "商品が存在しない場合" do
      it "空の状態を表示すること" do
        visit shopping_lists_path

        expect(page).to have_content("買い物リストが空です")
        expect(page).to have_content("商品を追加して買い物を始めましょう")
      end
    end

    context "商品追加機能" do
      it "商品を追加できること" do
        visit shopping_lists_path

        fill_in "shopping_item_name", with: "牛乳"
        click_button "追加"

        # Turbo Streamによる非同期更新を待つ
        expect(page).to have_content("牛乳")
        expect(page).to have_content("1件の商品")
      end

      it "商品名が空の場合エラーメッセージを表示すること" do
        visit shopping_lists_path

        fill_in "shopping_item_name", with: ""
        click_button "追加"

        # バリデーションエラーメッセージを確認
        expect(page).to have_content("Nameを入力してください")
      end

      it "Enterキーで商品を追加できること" do
        visit shopping_lists_path

        fill_in "shopping_item_name", with: "パン"
        find_field("shopping_item_name").send_keys(:return)

        expect(page).to have_content("パン")
      end
    end

    context "商品操作機能" do
      let!(:item1) { shopping_list.items.create!(name: "牛乳") }
      let!(:item2) { shopping_list.items.create!(name: "パン") }

      before do
        visit shopping_lists_path
      end

      it "商品をカートに追加できること" do
        # チェックボックスをクリック
        within "#item_#{item1.id}" do
          find('input[type="checkbox"]').check
        end

        # ピック済み状態を確認（背景色が変わる）
        expect(page).to have_css("#item_#{item1.id}.bg-stone-100")
        expect(page).to have_content("1件をカートに追加済み")
      end

      it "カート内商品のチェックを外すと未カート状態に戻ること" do
        # まずカートに追加
        within "#item_#{item1.id}" do
          find('input[type="checkbox"]').check
        end

        # チェックを外す
        within "#item_#{item1.id}" do
          find('input[type="checkbox"]').uncheck
        end

        expect(page).not_to have_css("#item_#{item1.id}.bg-stone-100")
        expect(page).to have_content("0件をカートに追加済み")
      end

      it "商品を編集できること" do
        within "#item_#{item1.id}" do
          click_button "編集"
        end

        # 編集フォームが表示される
        expect(page).to have_field("shopping_item_name", with: "牛乳")

        fill_in "shopping_item_name", with: "低脂肪牛乳"
        fill_in "shopping_item_quantity", with: "1L"
        fill_in "shopping_item_store_name", with: "スーパーA"
        fill_in "shopping_item_memo", with: "冷蔵コーナー"

        click_button "保存"

        # 更新された商品が表示される
        within "#item_#{item1.id}" do
          expect(page).to have_content("低脂肪牛乳")
          expect(page).to have_content("1L")
          expect(page).to have_content("スーパーA")
          expect(page).to have_content("冷蔵コーナー")
        end
      end

      it "編集をキャンセルできること" do
        within "#item_#{item1.id}" do
          click_button "編集"
        end

        click_link "キャンセル"

        # 編集フォームが閉じて元の表示に戻る
        within "#item_#{item1.id}" do
          expect(page).to have_content("牛乳")
          expect(page).not_to have_field("shopping_item_name")
        end
      end

      it "商品を削除できること", js: true do
        # 削除確認ダイアログを自動承認
        accept_confirm do
          within "#item_#{item1.id}" do
            click_button "削除"
          end
        end

        # 商品が削除される
        expect(page).not_to have_content("牛乳")
        expect(page).to have_content("1件の商品") # パンのみ残る
      end
    end

    context "カート内商品の一括削除" do
      let!(:item1) { shopping_list.items.create!(name: "牛乳", picked_at: Time.current) }
      let!(:item2) { shopping_list.items.create!(name: "パン", picked_at: Time.current) }
      let!(:item3) { shopping_list.items.create!(name: "卵") } # 未カート

      it "カート内商品をすべて削除できること" do
        visit shopping_lists_path

        expect(page).to have_button("カート内商品を削除 (2件)")

        accept_confirm do
          click_button "カート内商品を削除 (2件)"
        end

        # カート内商品が削除され、未カート商品のみ残る
        expect(page).not_to have_content("牛乳")
        expect(page).not_to have_content("パン")
        expect(page).to have_content("卵")
        expect(page).to have_content("1件の商品")
        expect(page).not_to have_button("カート内商品を削除")
      end
    end

    context "店舗フィルタリング" do
      let!(:item1) { shopping_list.items.create!(name: "牛乳", store_name: "スーパーA") }
      let!(:item2) { shopping_list.items.create!(name: "パン", store_name: "スーパーA") }
      let!(:item3) { shopping_list.items.create!(name: "シャンプー", store_name: "ドラッグストア") }
      let!(:item4) { shopping_list.items.create!(name: "その他") } # 店舗未設定

      before do
        visit shopping_lists_path
      end

      it "店舗フィルタボタンが表示されること" do
        expect(page).to have_link("すべて")
        expect(page).to have_link("スーパーA")
        expect(page).to have_link("ドラッグストア")
      end

      it "特定の店舗でフィルタできること" do
        click_link "スーパーA"

        # スーパーAの商品と店舗未設定商品が表示される
        expect(page).to have_content("牛乳")
        expect(page).to have_content("パン")
        expect(page).to have_content("その他")
        expect(page).not_to have_content("シャンプー")

        # フィルタ状態の表示を確認
        expect(page).to have_content("「スーパーA」でフィルタ中")
      end

      it "「すべて」を選択するとフィルタが解除されること" do
        click_link "スーパーA"
        click_link "すべて"

        # すべての商品が表示される
        expect(page).to have_content("牛乳")
        expect(page).to have_content("パン")
        expect(page).to have_content("シャンプー")
        expect(page).to have_content("その他")
        expect(page).not_to have_content("フィルタ中")
      end
    end

    context "モバイル最適化" do
      let!(:item) { shopping_list.items.create!(name: "牛乳") }

      before do
        # スマートフォンのビューポートサイズに変更
        page.driver.browser.manage.window.resize_to(375, 667)
        visit shopping_lists_path
      end

      it "モバイル画面で商品が表示されること" do
        expect(page).to have_content("牛乳")
      end

      it "タップターゲットが44x44px以上であること" do
        # 追加ボタンのサイズを確認
        button = find('button[type="submit"]', text: '追加')
        size = page.driver.browser.execute_script('return arguments[0].getBoundingClientRect();', button.native)

        expect(size['height']).to be >= 44
        expect(size['width']).to be >= 44
      end

      it "チェックボックスのタップターゲットが十分なサイズであること" do
        checkbox_label = within "#item_#{item.id}" do
          find('label[for^="item_picked_"]')
        end

        size = page.driver.browser.execute_script('return arguments[0].getBoundingClientRect();', checkbox_label.native)

        expect(size['height']).to be >= 44
        expect(size['width']).to be >= 44
      end
    end
  end
end
