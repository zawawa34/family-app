# frozen_string_literal: true

# User::SessionsController
# ユーザーのログイン・ログアウトを管理するコントローラー
# Deviseのデフォルトセッション機能を継承し、必要に応じてカスタマイズ
class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /users/sign_in
  # ログインフォームを表示
  # def new
  #   super
  # end

  # POST /users/sign_in
  # ログイン処理を実行
  # def create
  #   super
  # end

  # DELETE /users/sign_out
  # ログアウト処理を実行
  # def destroy
  #   super
  # end

  # protected

  # ログイン成功後のリダイレクト先を設定
  # デフォルトはroot_path、stored_locationがあればそちらを優先
  # def after_sign_in_path_for(resource)
  #   stored_location_for(resource) || root_path
  # end

  # ログアウト後のリダイレクト先を設定
  # def after_sign_out_path_for(resource_or_scope)
  #   new_user_database_authentication_session_path
  # end

  # Strong Parametersの設定（必要に応じてコメント解除）
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
