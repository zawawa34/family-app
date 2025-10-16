class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # DeviseのヘルパーメソッドをオーバーライドしてUserモデルを返す
  def current_user
    current_user_database_authentication&.user
  end
  helper_method :current_user

  def user_signed_in?
    user_database_authentication_signed_in?
  end
  helper_method :user_signed_in?

  def authenticate_user!
    authenticate_user_database_authentication!
  end
end
