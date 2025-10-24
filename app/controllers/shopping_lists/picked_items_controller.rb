module ShoppingLists
  class PickedItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_shopping_list

    # DELETE /shopping_lists/:shopping_list_id/picked_items
    # カート内商品を一括削除する
    def destroy
      @picked_items = @shopping_list.items.picked.to_a  # 配列化してからdestroyする
      @deleted_count = @picked_items.count
      @picked_items.each(&:destroy)

      respond_to do |format|
        format.turbo_stream
      end
    end

    private

    # デフォルトの買い物リストを設定
    def set_shopping_list
      @shopping_list = ShoppingList.default
    end
  end
end
