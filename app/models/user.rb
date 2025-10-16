class User < ApplicationRecord
  # 役割の定義
  enum :role, { admin: 0, general: 1 }, default: :general

  # 関連
  has_one :database_authentication, class_name: 'User::DatabaseAuthentication', dependent: :destroy
  # has_many :invitations, class_name: 'User::Invitation', foreign_key: :create_user_id, dependent: :destroy

  # バリデーション
  validates :role, presence: true
end
