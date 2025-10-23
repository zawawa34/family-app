class ShoppingList < ApplicationRecord
  # 関連
  has_many :items, class_name: "ShoppingItem", dependent: :destroy
  belongs_to :owner, class_name: "User", optional: true

  # バリデーション
  validates :name, presence: true

  # デフォルトリストの取得（現時点では1つのみ）
  def self.default
    first_or_create!(name: "買い物リスト")
  end

  # 商品の総数を取得
  def total_items_count
    items.count
  end

  # カート内商品数を取得
  def picked_items_count
    items.picked.count
  end

  # 未カート商品数を取得
  def unpicked_items_count
    items.unpicked.count
  end
end
