class ShoppingItem < ApplicationRecord
  # 関連
  belongs_to :shopping_list

  # 並び順管理（positioning gem）
  # shopping_listごとに独立した並び順を管理
  positioned on: :shopping_list

  # バリデーション
  validates :name, presence: true

  # スコープ
  scope :picked, -> { where.not(picked_at: nil) }
  scope :unpicked, -> { where(picked_at: nil) }
  scope :for_store, ->(store_name) { where(store_name: [ store_name, nil ]) }

  # ヘルパーメソッド
  def picked?
    picked_at.present?
  end

  def pick!
    update!(picked_at: Time.current)
  end

  def unpick!
    update!(picked_at: nil)
  end
end
