require 'rails_helper'

RSpec.describe "ShoppingLists::PickedItems", type: :request do
  let(:user) { create(:user) }
  let(:database_authentication) { create(:database_authentication, user: user) }
  let!(:shopping_list) { ShoppingList.create!(name: '買い物リスト') }

  describe "DELETE /shopping_lists/:shopping_list_id/picked_items" do
    context "未認証ユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        delete shopping_list_picked_items_path(shopping_list)
        expect(response).to redirect_to(new_user_database_authentication_session_path)
      end
    end

    context "認証済みユーザーの場合" do
      before { sign_in database_authentication }

      context "カート内商品が存在する場合" do
        let!(:picked_item1) { create(:shopping_item, shopping_list: shopping_list, picked_at: 1.hour.ago) }
        let!(:picked_item2) { create(:shopping_item, shopping_list: shopping_list, picked_at: 30.minutes.ago) }
        let!(:unpicked_item) { create(:shopping_item, shopping_list: shopping_list, picked_at: nil) }

        it "カート内商品をすべて削除すること" do
          expect {
            delete shopping_list_picked_items_path(shopping_list), as: :turbo_stream
          }.to change(ShoppingItem, :count).by(-2)
        end

        it "未カート商品は削除されないこと" do
          delete shopping_list_picked_items_path(shopping_list), as: :turbo_stream
          expect(ShoppingItem.exists?(unpicked_item.id)).to be true
        end

        it "Turbo Streamレスポンスを返すこと" do
          delete shopping_list_picked_items_path(shopping_list), as: :turbo_stream
          expect(response.media_type).to eq Mime[:turbo_stream]
        end

        it "削除件数の通知メッセージを返すこと" do
          delete shopping_list_picked_items_path(shopping_list), as: :turbo_stream
          expect(response.body).to include("2件の商品を削除しました")
        end
      end

      context "カート内商品が存在しない場合" do
        let!(:unpicked_item) { create(:shopping_item, shopping_list: shopping_list, picked_at: nil) }

        it "商品を削除しないこと" do
          expect {
            delete shopping_list_picked_items_path(shopping_list), as: :turbo_stream
          }.not_to change(ShoppingItem, :count)
        end

        it "削除件数の通知メッセージを表示しないこと" do
          delete shopping_list_picked_items_path(shopping_list), as: :turbo_stream
          expect(response.body).not_to include("件の商品を削除しました")
        end
      end
    end
  end
end
