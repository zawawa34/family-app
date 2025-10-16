require 'rails_helper'

RSpec.describe User::DatabaseAuthentication, type: :model do
  describe 'バリデーション' do
    it '有効なファクトリーを持つこと' do
      database_authentication = build(:database_authentication)
      expect(database_authentication).to be_valid
    end

    it 'emailが必須であること' do
      database_authentication = build(:database_authentication, email: nil)
      expect(database_authentication).not_to be_valid
      expect(database_authentication.errors[:email]).to include("can't be blank")
    end

    it 'emailがユニークであること' do
      create(:database_authentication, email: 'test@example.com')
      database_authentication = build(:database_authentication, email: 'test@example.com')
      expect(database_authentication).not_to be_valid
      expect(database_authentication.errors[:email]).to include('has already been taken')
    end

    it 'emailの形式が正しいこと' do
      valid_emails = ['user@example.com', 'test+tag@domain.co.jp', 'name.surname@company.org']
      valid_emails.each do |email|
        database_authentication = build(:database_authentication, email: email)
        expect(database_authentication).to be_valid, "#{email} should be valid"
      end
    end

    it '不正な形式のemailを拒否すること' do
      invalid_emails = ['invalid', '@example.com', 'user@', 'user @example.com']
      invalid_emails.each do |email|
        database_authentication = build(:database_authentication, email: email)
        expect(database_authentication).not_to be_valid, "#{email} should be invalid"
      end
    end

    it 'passwordが必須であること（新規作成時）' do
      database_authentication = build(:database_authentication, password: nil)
      expect(database_authentication).not_to be_valid
      expect(database_authentication.errors[:password]).to include("can't be blank")
    end

    it 'passwordが8文字以上であること' do
      database_authentication = build(:database_authentication, password: 'short')
      expect(database_authentication).not_to be_valid
      expect(database_authentication.errors[:password]).to include('is too short (minimum is 8 characters)')
    end

    it 'passwordが8文字以上の場合有効であること' do
      database_authentication = build(:database_authentication, password: 'validpass', password_confirmation: 'validpass')
      expect(database_authentication).to be_valid
    end
  end

  describe '関連' do
    it 'Userとの1対1の関連を持つこと' do
      association = User::DatabaseAuthentication.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
    end
  end

  describe 'パスワードの暗号化' do
    it 'passwordを保存時にbcryptでハッシュ化すること' do
      database_authentication = create(:database_authentication, password: 'testpassword', password_confirmation: 'testpassword')
      expect(database_authentication.encrypted_password).not_to be_nil
      expect(database_authentication.encrypted_password).not_to eq('testpassword')
      expect(database_authentication.encrypted_password).to start_with('$2a$')
    end

    it 'パスワードの検証が正しく動作すること' do
      database_authentication = create(:database_authentication, password: 'testpassword', password_confirmation: 'testpassword')
      expect(database_authentication.valid_password?('testpassword')).to be true
      expect(database_authentication.valid_password?('wrongpassword')).to be false
    end
  end

  describe 'remember me機能' do
    it 'remember_created_atカラムを持つこと' do
      database_authentication = create(:database_authentication)
      expect(database_authentication).to respond_to(:remember_created_at)
    end

    it 'remember_me!メソッドでremember_created_atを設定すること' do
      database_authentication = create(:database_authentication)
      expect(database_authentication.remember_created_at).to be_nil

      database_authentication.remember_me!
      expect(database_authentication.remember_created_at).not_to be_nil
      expect(database_authentication.remember_created_at).to be_within(1.second).of(Time.current)
    end
  end
end
