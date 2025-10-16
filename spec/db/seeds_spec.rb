require 'rails_helper'

RSpec.describe "db:seed", type: :task do
  before do
    # 既存のデータをクリア
    User::DatabaseAuthentication.destroy_all
    User.destroy_all
  end

  it "初期管理者を作成すること" do
    expect {
      load Rails.root.join('db', 'seeds.rb')
    }.to change(User, :count).by(1)
  end

  it "初期管理者の認証情報を作成すること" do
    expect {
      load Rails.root.join('db', 'seeds.rb')
    }.to change(User::DatabaseAuthentication, :count).by(1)
  end

  it "管理者役割を設定すること" do
    load Rails.root.join('db', 'seeds.rb')
    user = User.last
    expect(user.admin?).to be true
  end

  it "パスワードをbcryptでハッシュ化すること" do
    load Rails.root.join('db', 'seeds.rb')
    auth = User::DatabaseAuthentication.last
    expect(auth.encrypted_password).to start_with('$2a$')
    expect(auth.encrypted_password).not_to eq('password123')
  end

  it "既存の管理者がある場合はスキップすること" do
    # 最初のseed実行
    load Rails.root.join('db', 'seeds.rb')

    # 2回目のseed実行
    expect {
      load Rails.root.join('db', 'seeds.rb')
    }.not_to change(User, :count)
  end

  it "デフォルトのメールアドレスを使用すること" do
    load Rails.root.join('db', 'seeds.rb')
    auth = User::DatabaseAuthentication.last
    expect(auth.email).to eq('admin@example.com')
  end

  context "環境変数が設定されている場合" do
    around do |example|
      original_email = ENV['ADMIN_EMAIL']
      original_password = ENV['ADMIN_PASSWORD']

      ENV['ADMIN_EMAIL'] = 'custom@example.com'
      ENV['ADMIN_PASSWORD'] = 'custompass123'

      example.run

      ENV['ADMIN_EMAIL'] = original_email
      ENV['ADMIN_PASSWORD'] = original_password
    end

    it "環境変数のメールアドレスを使用すること" do
      load Rails.root.join('db', 'seeds.rb')
      auth = User::DatabaseAuthentication.last
      expect(auth.email).to eq('custom@example.com')
    end
  end
end
