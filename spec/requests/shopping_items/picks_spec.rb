require 'rails_helper'

RSpec.describe "ShoppingItems::Picks", type: :request do
  let(:user) { create(:user) }
  let(:database_authentication) { create(:database_authentication, user: user) }
  let!(:shopping_list) { ShoppingList.create!(name: '買い物リスト') }
  let!(:item) { shopping_list.items.create!(name: '商品A', quantity: '2個', store_name: 'スーパー') }

  describe "POST /shopping_lists/:shopping_list_id/items/:item_id/pick" do
    context "未認証ユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        post shopping_list_item_pick_path(shopping_list, item)
        expect(response).to redirect_to(new_user_database_authentication_session_path)
      end
    end

    context "認証済みユーザーの場合" do
      before do
        sign_in database_authentication
      end

      it "商品をピック状態にできること" do
        expect(item.picked?).to be false
        post shopping_list_item_pick_path(shopping_list, item), as: :turbo_stream
        item.reload
        expect(item.picked?).to be true
      end

      it "picked_atにタイムスタンプを記録すること" do
        expect(item.picked_at).to be_nil
        post shopping_list_item_pick_path(shopping_list, item), as: :turbo_stream
        item.reload
        expect(item.picked_at).to be_present
        expect(item.picked_at).to be_within(1.second).of(Time.current)
      end

      it "Turbo Streamレスポンスを返すこと" do
        post shopping_list_item_pick_path(shopping_list, item), as: :turbo_stream
        expect(response).to have_http_status(:success)
        expect(response.media_type).to eq 'text/vnd.turbo-stream.html'
      end
    end
  end

  describe "DELETE /shopping_lists/:shopping_list_id/items/:item_id/pick" do
    let!(:item) { shopping_list.items.create!(name: '商品A', picked_at: Time.current) }

    context "未認証ユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        delete shopping_list_item_pick_path(shopping_list, item)
        expect(response).to redirect_to(new_user_database_authentication_session_path)
      end
    end

    context "認証済みユーザーの場合" do
      before do
        sign_in database_authentication
      end

      it "商品のピック状態を解除できること" do
        expect(item.picked?).to be true
        delete shopping_list_item_pick_path(shopping_list, item), as: :turbo_stream
        item.reload
        expect(item.picked?).to be false
      end

      it "picked_atをnilにすること" do
        expect(item.picked_at).to be_present
        delete shopping_list_item_pick_path(shopping_list, item), as: :turbo_stream
        item.reload
        expect(item.picked_at).to be_nil
      end

      it "Turbo Streamレスポンスを返すこと" do
        delete shopping_list_item_pick_path(shopping_list, item), as: :turbo_stream
        expect(response).to have_http_status(:success)
        expect(response.media_type).to eq 'text/vnd.turbo-stream.html'
      end
    end
  end
end
