module ShoppingItems
  class PositionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_shopping_list
    before_action :set_item

    # PATCH /shopping_lists/:shopping_list_id/items/:item_id/position
    # ドラッグ&ドロップで並び順を更新
    #
    # パラメータ:
    #   position: { after: id } - 指定したid の商品の後に配置
    #   position: { after: null } - リストの先頭に配置
    def update
      # positioning gemに直接渡す
      # { after: id } または { after: null } の形式
      # positioning gemが自動的に他の商品のpositionを再計算
      # row-level lockにより並行操作の整合性を保証
      @item.update!(position: position_params)

      render json: { success: true }
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error("Position update failed - item not found: #{e.message}")
      render json: { success: false, error: '商品が見つかりません' }, status: :not_found
    rescue => e
      Rails.logger.error("Position update failed: #{e.message}")
      render json: { success: false, error: '並び替えに失敗しました' }, status: :unprocessable_entity
    end

    private

    # デフォルトの買い物リストを設定
    def set_shopping_list
      @shopping_list = ShoppingList.default
    end

    # 操作対象の商品を設定
    def set_item
      @item = @shopping_list.items.find(params[:item_id])
    end

    # positioning gemに渡すパラメータ
    # { after: id } または { after: null } の形式
    # Strong Parametersを通したハッシュをシンボルキーに変換
    def position_params
      params.require(:position).permit(:after).to_h.symbolize_keys
    end
  end
end
