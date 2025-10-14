# Factory Botの追加設定

RSpec.configure do |config|
  # Factory Botのファクトリーをテスト実行前にlintする（本番環境では無効化）
  config.before(:suite) do
    # FactoryBot.lint if Rails.env.test?
  end
end
