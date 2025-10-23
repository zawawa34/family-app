class ShoppingList < ApplicationRecord
  # 関連
  has_many :items, class_name: "ShoppingItem", dependent: :destroy
  belongs_to :owner, class_name: "User", optional: true

  # バリデーション
  validates :name, presence: true
end
