require 'rails_helper'

RSpec.describe "ShoppingItems", type: :request do
  let(:user) { create(:user) }
  let(:database_authentication) { create(:database_authentication, user: user) }
  let!(:shopping_list) { ShoppingList.create!(name: '買い物リスト') }

  describe "POST /shopping_lists/:shopping_list_id/items" do
    context "未認証ユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        post shopping_list_items_path(shopping_list), params: { shopping_item: { name: '商品A' } }
        expect(response).to redirect_to(new_user_database_authentication_session_path)
      end
    end

    context "認証済みユーザーの場合" do
      before do
        sign_in database_authentication
      end

      context "有効なパラメータの場合" do
        it "商品を作成できること" do
          expect {
            post shopping_list_items_path(shopping_list), params: { shopping_item: { name: '商品A' } }, as: :turbo_stream
          }.to change(ShoppingItem, :count).by(1)
        end

        it "商品を未ピック状態で作成すること" do
          post shopping_list_items_path(shopping_list), params: { shopping_item: { name: '商品A' } }, as: :turbo_stream
          expect(ShoppingItem.last.picked?).to be false
        end

        it "商品をリストの末尾に配置すること" do
          shopping_list.items.create!(name: '既存商品', position: 1)
          post shopping_list_items_path(shopping_list), params: { shopping_item: { name: '新商品' } }, as: :turbo_stream
          expect(ShoppingItem.last.position).to be > 1
        end

        it "数量・メモ・購入店舗が空の場合はnullとして登録すること" do
          post shopping_list_items_path(shopping_list), params: { shopping_item: { name: '商品A' } }, as: :turbo_stream
          item = ShoppingItem.last
          expect(item.quantity).to be_nil
          expect(item.memo).to be_nil
          expect(item.store_name).to be_nil
        end

        it "数量・メモ・購入店舗を指定できること" do
          post shopping_list_items_path(shopping_list), params: {
            shopping_item: {
              name: '商品A',
              quantity: '2個',
              memo: 'メモ',
              store_name: 'スーパー'
            }
          }, as: :turbo_stream
          item = ShoppingItem.last
          expect(item.quantity).to eq('2個')
          expect(item.memo).to eq('メモ')
          expect(item.store_name).to eq('スーパー')
        end

        it "Turbo Streamレスポンスを返すこと" do
          post shopping_list_items_path(shopping_list), params: { shopping_item: { name: '商品A' } }, as: :turbo_stream
          expect(response).to have_http_status(:success)
          expect(response.media_type).to eq 'text/vnd.turbo-stream.html'
        end
      end

      context "無効なパラメータの場合" do
        it "商品名が空の場合、商品を作成しないこと" do
          expect {
            post shopping_list_items_path(shopping_list), params: { shopping_item: { name: '' } }, as: :turbo_stream
          }.not_to change(ShoppingItem, :count)
        end

        it "商品名が空の場合、バリデーションエラーを返すこと" do
          post shopping_list_items_path(shopping_list), params: { shopping_item: { name: '' } }, as: :turbo_stream
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "商品名が空の場合、エラーメッセージを含むTurbo Streamを返すこと" do
          post shopping_list_items_path(shopping_list), params: { shopping_item: { name: '' } }, as: :turbo_stream
          expect(response.media_type).to eq 'text/vnd.turbo-stream.html'
        end
      end
    end
  end

  describe "GET /shopping_lists/:shopping_list_id/items/:id/edit" do
    let!(:item) { shopping_list.items.create!(name: '商品A', quantity: '2個', store_name: 'スーパー') }

    context "未認証ユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        get edit_shopping_list_item_path(shopping_list, item)
        expect(response).to redirect_to(new_user_database_authentication_session_path)
      end
    end

    context "認証済みユーザーの場合" do
      before do
        sign_in database_authentication
      end

      it "編集フォームを表示すること" do
        get edit_shopping_list_item_path(shopping_list, item), as: :turbo_stream
        expect(response).to have_http_status(:success)
        expect(response.media_type).to eq 'text/vnd.turbo-stream.html'
      end
    end
  end

  describe "PATCH /shopping_lists/:shopping_list_id/items/:id" do
    let!(:item) { shopping_list.items.create!(name: '商品A', quantity: '2個', store_name: 'スーパー') }

    context "未認証ユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        patch shopping_list_item_path(shopping_list, item), params: { shopping_item: { name: '商品B' } }
        expect(response).to redirect_to(new_user_database_authentication_session_path)
      end
    end

    context "認証済みユーザーの場合" do
      before do
        sign_in database_authentication
      end

      context "有効なパラメータの場合" do
        it "商品情報を更新できること" do
          patch shopping_list_item_path(shopping_list, item), params: {
            shopping_item: {
              name: '商品B',
              quantity: '3個',
              memo: '更新メモ',
              store_name: 'コンビニ'
            }
          }, as: :turbo_stream

          item.reload
          expect(item.name).to eq('商品B')
          expect(item.quantity).to eq('3個')
          expect(item.memo).to eq('更新メモ')
          expect(item.store_name).to eq('コンビニ')
        end

        it "Turbo Streamレスポンスを返すこと" do
          patch shopping_list_item_path(shopping_list, item), params: {
            shopping_item: { name: '商品B' }
          }, as: :turbo_stream

          expect(response).to have_http_status(:success)
          expect(response.media_type).to eq 'text/vnd.turbo-stream.html'
        end
      end

      context "無効なパラメータの場合" do
        it "商品名が空の場合、商品を更新しないこと" do
          original_name = item.name
          patch shopping_list_item_path(shopping_list, item), params: {
            shopping_item: { name: '' }
          }, as: :turbo_stream

          item.reload
          expect(item.name).to eq(original_name)
        end

        it "商品名が空の場合、バリデーションエラーを返すこと" do
          patch shopping_list_item_path(shopping_list, item), params: {
            shopping_item: { name: '' }
          }, as: :turbo_stream

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "商品名が空の場合、エラーメッセージを含むTurbo Streamを返すこと" do
          patch shopping_list_item_path(shopping_list, item), params: {
            shopping_item: { name: '' }
          }, as: :turbo_stream

          expect(response.media_type).to eq 'text/vnd.turbo-stream.html'
        end
      end
    end
  end
end
