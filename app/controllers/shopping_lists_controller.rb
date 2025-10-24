class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  # GET /shopping_lists
  # 買い物リスト一覧画面を表示
  # パラメータ:
  #   store: 店舗名でフィルタリング（オプショナル）
  def index
    @shopping_list = ShoppingList.default
    @current_store = params[:store]

    # 店舗フィルタリング
    @items = if @current_store.present?
               # 指定店舗の商品 + 店舗未設定商品
               @shopping_list.items.for_store(@current_store).order(:position)
             else
               # すべての商品
               @shopping_list.items.order(:position)
             end

    # 登録されている店舗名の一覧を取得（フィルタUIで使用）
    @available_stores = @shopping_list.items
                                      .where.not(store_name: nil)
                                      .distinct
                                      .pluck(:store_name)
                                      .sort
  end
end
