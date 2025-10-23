class ShoppingItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shopping_list
  before_action :set_item, only: [:edit, :update, :destroy]

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

  # GET /shopping_lists/:shopping_list_id/items/:id/edit
  # 商品編集フォームを表示
  def edit
    respond_to do |format|
      format.turbo_stream
    end
  end

  # PATCH /shopping_lists/:shopping_list_id/items/:id
  # 商品情報を更新
  def update
    if @item.update(item_params)
      # 成功時: Turbo Streamで商品を更新
      respond_to do |format|
        format.turbo_stream
      end
    else
      # バリデーションエラー時: エラーメッセージを含むフォームを返す
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "edit_item_#{@item.id}",
            partial: 'shopping_items/edit_form',
            locals: { shopping_list: @shopping_list, item: @item }
          ), status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /shopping_lists/:shopping_list_id/items/:id
  # 商品を削除
  def destroy
    @item.destroy

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
    @item = @shopping_list.items.find(params[:id])
  end

  # Strong Parameters
  def item_params
    params.require(:shopping_item).permit(:name, :quantity, :memo, :store_name)
  end
end
