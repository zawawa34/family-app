require 'rails_helper'

RSpec.describe "ShoppingItems::AutocompleteStores", type: :request do
  let(:user) { create(:user) }
  let(:database_authentication) { create(:database_authentication, user: user) }
  let!(:shopping_list) { ShoppingList.create!(name: '買い物リスト') }

  describe "GET /shopping_lists/:shopping_list_id/items/autocomplete_stores" do
    context "未認証ユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        get autocomplete_stores_shopping_list_items_path(shopping_list), params: { q: 'スーパー' }
        expect(response).to redirect_to(new_user_database_authentication_session_path)
      end
    end

    context "認証済みユーザーの場合" do
      before { sign_in database_authentication }

      context "店舗名が登録されている場合" do
        let!(:item1) { shopping_list.items.create!(name: '牛乳', store_name: 'スーパーA') }
        let!(:item2) { shopping_list.items.create!(name: 'パン', store_name: 'スーパーB') }
        let!(:item3) { shopping_list.items.create!(name: 'シャンプー', store_name: 'ドラッグストア') }
        let!(:item4) { shopping_list.items.create!(name: '牛乳2', store_name: 'スーパーA') } # 重複

        it "部分一致する店舗名を返すこと" do
          get autocomplete_stores_shopping_list_items_path(shopping_list), params: { q: 'スーパー' }, as: :json
          expect(response).to have_http_status(:success)
          json = JSON.parse(response.body)
          expect(json).to include('スーパーA', 'スーパーB')
          expect(json).not_to include('ドラッグストア')
        end

        it "重複する店舗名は1回だけ返すこと" do
          get autocomplete_stores_shopping_list_items_path(shopping_list), params: { q: 'スーパー' }, as: :json
          expect(response).to have_http_status(:success)
          json = JSON.parse(response.body)
          expect(json.count('スーパーA')).to eq(1)
        end

        it "使用頻度順（降順）で返すこと" do
          # スーパーAは2回使用、スーパーBは1回使用
          get autocomplete_stores_shopping_list_items_path(shopping_list), params: { q: 'スーパー' }, as: :json
          expect(response).to have_http_status(:success)
          json = JSON.parse(response.body)
          expect(json.first).to eq('スーパーA')  # より多く使われている
        end

        it "最大10件まで返すこと" do
          # 11件の異なる店舗を作成
          (1..11).each do |i|
            shopping_list.items.create!(name: "商品#{i}", store_name: "スーパー#{i}")
          end

          get autocomplete_stores_shopping_list_items_path(shopping_list), params: { q: 'スーパー' }, as: :json
          expect(response).to have_http_status(:success)
          json = JSON.parse(response.body)
          expect(json.length).to eq(10)
        end

        it "部分一致で前方・後方・中間マッチすること" do
          get autocomplete_stores_shopping_list_items_path(shopping_list), params: { q: 'ーパー' }, as: :json
          expect(response).to have_http_status(:success)
          json = JSON.parse(response.body)
          expect(json).to include('スーパーA', 'スーパーB')
        end

        it "JSON形式で返すこと" do
          get autocomplete_stores_shopping_list_items_path(shopping_list), params: { q: 'スーパー' }, as: :json
          expect(response.content_type).to match(/application\/json/)
        end
      end

      context "検索クエリが空の場合" do
        let!(:item1) { shopping_list.items.create!(name: '牛乳', store_name: 'スーパーA') }

        it "空の配列を返すこと" do
          get autocomplete_stores_shopping_list_items_path(shopping_list), params: { q: '' }, as: :json
          expect(response).to have_http_status(:success)
          json = JSON.parse(response.body)
          expect(json).to eq([])
        end
      end

      context "店舗名が登録されていない場合" do
        it "空の配列を返すこと" do
          get autocomplete_stores_shopping_list_items_path(shopping_list), params: { q: 'スーパー' }, as: :json
          expect(response).to have_http_status(:success)
          json = JSON.parse(response.body)
          expect(json).to eq([])
        end
      end
    end
  end
end
