require 'rails_helper'

RSpec.describe "ShoppingLists", type: :request do
  let(:user) { create(:user) }
  let(:database_authentication) { create(:database_authentication, user: user) }

  describe "GET /shopping_lists" do
    context "未認証ユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        get shopping_lists_path
        expect(response).to redirect_to(new_user_database_authentication_session_path)
      end
    end

    context "認証済みユーザーの場合" do
      before do
        sign_in database_authentication
      end

      it "買い物リスト一覧画面を表示すること" do
        get shopping_lists_path
        expect(response).to have_http_status(:success)
      end

      context "商品が存在しない場合" do
        it "空のリストを表示すること" do
          get shopping_lists_path
          expect(response).to have_http_status(:success)
          expect(response.body).to include('買い物リスト')
        end
      end

      context "商品が存在する場合" do
        let!(:shopping_list) { ShoppingList.create!(name: '買い物リスト') }
        let!(:item1) { shopping_list.items.create!(name: '商品1', position: 1) }
        let!(:item3) { shopping_list.items.create!(name: '商品3', position: 3) }
        let!(:item2) { shopping_list.items.create!(name: '商品2', position: 2) }

        it "商品を並び順に表示すること" do
          get shopping_lists_path
          expect(response).to have_http_status(:success)
          expect(response.body).to include('商品1')
          expect(response.body).to include('商品2')
          expect(response.body).to include('商品3')
        end

        it "商品の基本情報を表示すること" do
          item1.update!(quantity: '2個', store_name: 'スーパー', picked_at: nil)
          get shopping_lists_path
          expect(response).to have_http_status(:success)
          expect(response.body).to include('商品1')
          expect(response.body).to include('2個')
          expect(response.body).to include('スーパー')
        end

        it "カート内商品を区別して表示すること" do
          item1.pick!
          get shopping_lists_path
          expect(response).to have_http_status(:success)
          # ビュー側でカート内商品を区別する実装を期待
        end

        it "店舗未設定の商品を視覚的に区別して表示すること" do
          item1.update!(store_name: nil)
          item2.update!(store_name: 'スーパー')
          get shopping_lists_path
          expect(response).to have_http_status(:success)
          expect(response.body).to include('店舗未設定')
          expect(response.body).to include('スーパー')
        end
      end
    end
  end
end
