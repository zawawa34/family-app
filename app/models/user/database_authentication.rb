class User::DatabaseAuthentication < ApplicationRecord
  # Deviseモジュール
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  # 関連
  belongs_to :user, class_name: "User"
end
