require 'rails_helper'

RSpec.describe "User::Sessions", type: :request do
  let(:user) { create(:user) }
  let(:database_authentication) { create(:database_authentication, user: user, email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

  describe "GET /users/sign_in" do
    it "ログインフォームを表示すること" do
      get new_user_database_authentication_session_path
      expect(response).to have_http_status(:success)
    end

    context "既にログインしている場合" do
      before do
        sign_in database_authentication
      end

      it "ホーム画面にリダイレクトすること" do
        get new_user_database_authentication_session_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST /users/sign_in" do
    before do
      database_authentication # レコードを作成
    end

    context "正しい認証情報の場合" do
      it "ログインに成功すること" do
        post user_database_authentication_session_path, params: {
          user_database_authentication: {
            email: 'test@example.com',
            password: 'password123'
          }
        }
        expect(response).to redirect_to(root_path)
      end

      it "セッションを作成すること" do
        post user_database_authentication_session_path, params: {
          user_database_authentication: {
            email: 'test@example.com',
            password: 'password123'
          }
        }
        follow_redirect!
        expect(response).to have_http_status(:success)
        expect(response.body).to include('ホーム')
      end
    end

    context "誤った認証情報の場合" do
      it "ログインに失敗すること" do
        post user_database_authentication_session_path, params: {
          user_database_authentication: {
            email: 'test@example.com',
            password: 'wrongpassword'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "ログインフォームが再表示されること" do
        post user_database_authentication_session_path, params: {
          user_database_authentication: {
            email: 'test@example.com',
            password: 'wrongpassword'
          }
        }
        expect(response.body).to include('ログイン')
      end
    end
  end

  describe "DELETE /users/sign_out" do
    before do
      sign_in database_authentication
    end

    it "ログアウトに成功すること" do
      delete destroy_user_database_authentication_session_path
      expect(response).to redirect_to(root_path)
    end

    it "セッションを破棄すること" do
      delete destroy_user_database_authentication_session_path

      # 認証が必要なページにアクセスして、ログインページにリダイレクトされることを確認
      get root_path
      expect(response).to redirect_to(new_user_database_authentication_session_path)
    end
  end
end
