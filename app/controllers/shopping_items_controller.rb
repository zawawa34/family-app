class ShoppingItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shopping_list

  # POST /shopping_lists/:shopping_list_id/items
  # 商品を追加
  def create
    @item = @shopping_list.items.build(item_params)

    if @item.save
      # 成功時: Turbo Streamで商品をリストに追加し、フォームをクリア
      respond_to do |format|
        format.turbo_stream
      end
    else
      # バリデーションエラー時: エラーメッセージを含むフォームを返す
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'new_item_form',
            partial: 'shopping_items/form',
            locals: { shopping_list: @shopping_list, item: @item }
          ), status: :unprocessable_entity
        end
      end
    end
  end

  private

  # デフォルトの買い物リストを設定
  def set_shopping_list
    @shopping_list = ShoppingList.default
  end

  # Strong Parameters
  def item_params
    params.require(:shopping_item).permit(:name, :quantity, :memo, :store_name)
  end
end
