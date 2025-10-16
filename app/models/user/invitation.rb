class User::Invitation < ApplicationRecord
  # ステータスの定義
  enum :status, { unused: 0, used: 1 }, default: :unused

  # 関連
  belongs_to :create_user, class_name: 'User', foreign_key: :create_user_id

  # バリデーション
  validates :token, presence: true, uniqueness: true
  validates :expires_at, presence: true
  validates :status, presence: true

  # コールバック
  before_validation :generate_token, if: -> { token.blank? }
  before_validation :set_default_expires_at, if: -> { expires_at.blank? }

  # 招待が有効かどうかを判定する
  def valid_invitation?
    unused? && expires_at > Time.current
  end

  # 招待を使用済みにする
  def mark_as_used!
    update!(status: :used)
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(32)
  end

  def set_default_expires_at
    self.expires_at = 7.days.from_now
  end
end
