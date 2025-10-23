class ShoppingItem < ApplicationRecord
  # 関連
  belongs_to :shopping_list

  # バリデーション
  validates :name, presence: true
end
