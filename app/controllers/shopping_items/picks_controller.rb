module ShoppingItems
  class PicksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_shopping_list
    before_action :set_item

    # POST /shopping_lists/:shopping_list_id/items/:item_id/pick
    # 商品を買い物カートに入れる（ピックする）
    def create
      @item.pick!

      respond_to do |format|
        format.turbo_stream
      end
    end

    # DELETE /shopping_lists/:shopping_list_id/items/:item_id/pick
    # 商品を買い物カートから出す（ピックを解除する）
    def destroy
      @item.unpick!

      respond_to do |format|
        format.turbo_stream
      end
    end

    private

    # デフォルトの買い物リストを設定
    def set_shopping_list
      @shopping_list = ShoppingList.default
    end

    # 商品を設定
    def set_item
      @item = @shopping_list.items.find(params[:item_id])
    end
  end
end
