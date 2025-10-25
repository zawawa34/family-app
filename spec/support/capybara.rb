# Capybaraの設定

RSpec.configure do |config|
  # システムテストでDeviseのヘルパーを有効化
  config.include Devise::Test::IntegrationHelpers, type: :system
  config.include Warden::Test::Helpers, type: :system
end

# Capybaraのドライバー設定
Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless=new') # 新しいヘッドレスモード
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# デフォルトのドライバーをヘッドレスChromeに設定
Capybara.javascript_driver = :headless_chrome

# サーバー設定
Capybara.server = :puma, { Silent: true }
