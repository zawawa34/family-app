# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# 初期管理者の作成
puts "Creating initial admin user..."

# 管理者のメールアドレスとパスワードを環境変数から取得（本番環境用）
# 開発環境ではデフォルト値を使用
admin_email = ENV.fetch('ADMIN_EMAIL', 'admin@example.com')
admin_password = ENV.fetch('ADMIN_PASSWORD', 'password123')

# 既存の管理者をチェック
existing_auth = User::DatabaseAuthentication.find_by(email: admin_email)

if existing_auth
  puts "Admin user already exists with email: #{admin_email}"
else
  # トランザクションで管理者ユーザーと認証情報を作成
  ActiveRecord::Base.transaction do
    # 管理者Userを作成
    admin_user = User.create!(role: :admin)

    # 認証情報を作成
    admin_auth = User::DatabaseAuthentication.create!(
      user: admin_user,
      email: admin_email,
      password: admin_password,
      password_confirmation: admin_password
    )

    puts "✓ Created admin user with email: #{admin_email}"
    puts "  Password: #{admin_password}"
    puts "  Note: Please change the password after first login in production!"
  end
end

puts "Seed data loaded successfully!"
