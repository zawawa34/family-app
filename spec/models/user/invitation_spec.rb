require 'rails_helper'

RSpec.describe User::Invitation, type: :model do
  describe 'バリデーション' do
    it '有効なファクトリーを持つこと' do
      invitation = build(:invitation)
      expect(invitation).to be_valid
    end

    it 'tokenがユニークであること' do
      create(:invitation, token: 'unique-token-123')
      invitation = build(:invitation, token: 'unique-token-123')
      expect(invitation).not_to be_valid
      expect(invitation.errors[:token]).to include('has already been taken')
    end

    it 'statusが必須であること' do
      invitation = build(:invitation, status: nil)
      expect(invitation).not_to be_valid
      expect(invitation.errors[:status]).to include("can't be blank")
    end
  end

  describe 'enum status' do
    it 'unusedステータスを持つこと' do
      invitation = create(:invitation, :unused)
      expect(invitation.status).to eq('unused')
      expect(invitation.unused?).to be true
      expect(invitation.used?).to be false
    end

    it 'usedステータスを持つこと' do
      invitation = create(:invitation, :used)
      expect(invitation.status).to eq('used')
      expect(invitation.used?).to be true
      expect(invitation.unused?).to be false
    end

    it 'デフォルトでunusedステータスであること' do
      invitation = create(:invitation)
      expect(invitation.status).to eq('unused')
      expect(invitation.unused?).to be true
    end
  end

  describe '関連' do
    it 'create_userとの関連を持つこと' do
      association = User::Invitation.reflect_on_association(:create_user)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
      expect(association.options[:foreign_key]).to eq(:create_user_id)
    end
  end

  describe 'トークン生成' do
    it 'tokenが自動生成されること' do
      invitation = create(:invitation, token: nil)
      expect(invitation.token).not_to be_nil
      expect(invitation.token.length).to be >= 20
    end

    it '複数の招待で異なるトークンが生成されること' do
      invitation1 = create(:invitation, token: nil)
      invitation2 = create(:invitation, token: nil)
      expect(invitation1.token).not_to eq(invitation2.token)
    end
  end

  describe '有効期限' do
    it 'expires_atが設定されていない場合、作成時に7日後が設定されること' do
      invitation = create(:invitation, expires_at: nil)
      expect(invitation.expires_at).to be_within(1.second).of(7.days.from_now)
    end

    it 'expires_atが明示的に設定された場合、その値が使用されること' do
      custom_date = 3.days.from_now
      invitation = create(:invitation, expires_at: custom_date)
      expect(invitation.expires_at).to be_within(1.second).of(custom_date)
    end
  end

  describe '#valid_invitation?' do
    it '期限内でunusedの場合にtrueを返すこと' do
      invitation = create(:invitation, expires_at: 1.day.from_now, status: :unused)
      expect(invitation.valid_invitation?).to be true
    end

    it '期限切れの場合にfalseを返すこと' do
      invitation = create(:invitation, expires_at: 1.day.ago, status: :unused)
      expect(invitation.valid_invitation?).to be false
    end

    it 'usedステータスの場合にfalseを返すこと' do
      invitation = create(:invitation, expires_at: 1.day.from_now, status: :used)
      expect(invitation.valid_invitation?).to be false
    end

    it '期限切れかつusedの場合にfalseを返すこと' do
      invitation = create(:invitation, expires_at: 1.day.ago, status: :used)
      expect(invitation.valid_invitation?).to be false
    end
  end

  describe '#mark_as_used!' do
    it 'ステータスをusedに変更すること' do
      invitation = create(:invitation, status: :unused)
      expect { invitation.mark_as_used! }.to change { invitation.status }.from('unused').to('used')
    end

    it 'データベースに保存されること' do
      invitation = create(:invitation, status: :unused)
      invitation.mark_as_used!
      invitation.reload
      expect(invitation.used?).to be true
    end
  end
end
