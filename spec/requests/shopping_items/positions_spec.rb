require 'rails_helper'

RSpec.describe "ShoppingItems::Positions", type: :request do
  let(:user) { create(:user) }
  let(:database_authentication) { create(:database_authentication, user: user) }
  let!(:shopping_list) { ShoppingList.create!(name: '買い物リスト') }
  let!(:item1) { shopping_list.items.create!(name: '商品A') }
  let!(:item2) { shopping_list.items.create!(name: '商品B') }
  let!(:item3) { shopping_list.items.create!(name: '商品C') }

  describe "PATCH /shopping_lists/:shopping_list_id/items/:item_id/position" do
    context "未認証ユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        patch shopping_list_item_position_path(shopping_list, item1),
              params: { position: { after: nil } },
              as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "認証済みユーザーの場合" do
      before { sign_in database_authentication }

      context "リストの先頭に移動する場合（after: null）" do
        it "商品をリストの先頭に移動できること" do
          # 初期状態: item1(pos:1), item2(pos:2), item3(pos:3)
          # item3を先頭に移動
          patch shopping_list_item_position_path(shopping_list, item3),
                params: { position: { after: nil } },
                as: :json

          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)['success']).to be true

          # 並び順を確認: item3が先頭になる
          items = shopping_list.items.order(:position)
          expect(items.map(&:name)).to eq(['商品C', '商品A', '商品B'])
        end
      end

      context "特定商品の後ろに移動する場合（after: id）" do
        it "商品を指定した商品の後ろに移動できること" do
          # 初期状態: item1(pos:1), item2(pos:2), item3(pos:3)
          # item1をitem3の後ろに移動
          patch shopping_list_item_position_path(shopping_list, item1),
                params: { position: { after: item3.id } },
                as: :json

          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)['success']).to be true

          # 並び順を確認: item1がitem3の後ろになる
          items = shopping_list.items.order(:position)
          expect(items.map(&:name)).to eq(['商品B', '商品C', '商品A'])
        end

        it "商品を中間位置に移動できること" do
          # 初期状態: item1(pos:1), item2(pos:2), item3(pos:3)
          # item3をitem1の後ろに移動
          patch shopping_list_item_position_path(shopping_list, item3),
                params: { position: { after: item1.id } },
                as: :json

          expect(response).to have_http_status(:success)

          # 並び順を確認: item3がitem1とitem2の間になる
          items = shopping_list.items.order(:position)
          expect(items.map(&:name)).to eq(['商品A', '商品C', '商品B'])
        end
      end

      context "エラーケース" do
        it "存在しない商品IDの場合はエラーを返すこと" do
          patch shopping_list_item_position_path(shopping_list, 99999),
                params: { position: { after: nil } },
                as: :json

          expect(response).to have_http_status(:not_found)
        end

        it "不正なパラメータの場合はエラーを返すこと" do
          patch shopping_list_item_position_path(shopping_list, item1),
                params: { invalid: 'param' },
                as: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "JSON形式のレスポンス" do
        it "成功時にsuccess: trueを返すこと" do
          patch shopping_list_item_position_path(shopping_list, item1),
                params: { position: { after: item2.id } },
                as: :json

          expect(response.content_type).to match(/application\/json/)
          json = JSON.parse(response.body)
          expect(json).to have_key('success')
          expect(json['success']).to be true
        end
      end
    end
  end
end
