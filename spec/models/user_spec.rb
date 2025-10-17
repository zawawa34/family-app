require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '有効なファクトリーを持つこと' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'roleが必須であること' do
      user = build(:user, role: nil)
      expect(user).not_to be_valid
      expect(user.errors[:role]).to include("can't be blank")
    end
  end

  describe 'enum role' do
    it '管理者ロールを持つこと' do
      user = create(:user, :admin)
      expect(user.role).to eq('admin')
      expect(user.admin?).to be true
      expect(user.general?).to be false
    end

    it '一般ユーザーロールを持つこと' do
      user = create(:user, :general)
      expect(user.role).to eq('general')
      expect(user.general?).to be true
      expect(user.admin?).to be false
    end

    it 'デフォルトで一般ユーザーであること' do
      user = create(:user)
      expect(user.role).to eq('general')
      expect(user.general?).to be true
    end
  end

  describe '関連' do
    it 'database_authenticationとの1対1の関連を持つこと' do
      association = User.reflect_on_association(:database_authentication)
      expect(association.macro).to eq(:has_one)
      expect(association.options[:class_name]).to eq('User::DatabaseAuthentication')
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'invitationsとの1対多の関連を持つこと' do
      association = User.reflect_on_association(:invitations)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('User::Invitation')
      expect(association.options[:foreign_key]).to eq(:create_user_id)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
end
