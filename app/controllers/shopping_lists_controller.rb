class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  # GET /shopping_lists
  # 買い物リスト一覧画面を表示
  def index
    @shopping_list = ShoppingList.default
    @items = @shopping_list.items.order(:position)
  end
end
