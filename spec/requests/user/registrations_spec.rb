require 'rails_helper'

RSpec.describe "User::Registrations", type: :request do
  let(:admin_user) { create(:user, :admin) }
  let!(:valid_invitation) { create(:invitation, create_user: admin_user, status: :unused, expires_at: 1.day.from_now) }
  let!(:used_invitation) { create(:invitation, create_user: admin_user, status: :used, expires_at: 1.day.from_now) }
  let!(:expired_invitation) { create(:invitation, create_user: admin_user, status: :unused, expires_at: 1.day.ago) }

  describe "GET /users/sign_up" do
    context "有効な招待トークンがある場合" do
      it "登録フォームを表示すること" do
        get '/users/sign_up', params: { invitation_token: valid_invitation.token }
        expect(response).to have_http_status(:success)
        expect(response.body).to include('アカウント登録')
      end
    end

    context "無効な招待トークンの場合" do
      it "エラーメッセージを表示すること" do
        get '/users/sign_up', params: { invitation_token: 'invalid-token' }
        expect(response).to redirect_to('/users/sign_in')
        follow_redirect!
        expect(response.body).to include('招待リンクが無効または期限切れです')
      end
    end

    context "使用済みの招待トークンの場合" do
      it "エラーメッセージを表示すること" do
        get '/users/sign_up', params: { invitation_token: used_invitation.token }
        expect(response).to redirect_to('/users/sign_in')
        follow_redirect!
        expect(response.body).to include('招待リンクが無効または期限切れです')
      end
    end

    context "期限切れの招待トークンの場合" do
      it "エラーメッセージを表示すること" do
        get '/users/sign_up', params: { invitation_token: expired_invitation.token }
        expect(response).to redirect_to('/users/sign_in')
        follow_redirect!
        expect(response.body).to include('招待リンクが無効または期限切れです')
      end
    end

    context "招待トークンがない場合" do
      it "エラーメッセージを表示すること" do
        get '/users/sign_up'
        expect(response).to redirect_to('/users/sign_in')
        follow_redirect!
        expect(response.body).to include('招待リンクが無効または期限切れです')
      end
    end
  end

  describe "POST /users" do
    context "有効な招待トークンと正しいパラメータの場合" do
      it "ユーザーを作成すること" do
        expect {
          post '/users', params: {
            invitation_token: valid_invitation.token,
            user_database_authentication: {
              email: 'newuser@example.com',
              password: 'password123',
              password_confirmation: 'password123'
            }
          }
        }.to change(User, :count).by(1)
      end

      it "認証情報を作成すること" do
        expect {
          post '/users', params: {
            invitation_token: valid_invitation.token,
            user_database_authentication: {
              email: 'newuser@example.com',
              password: 'password123',
              password_confirmation: 'password123'
            }
          }
        }.to change(User::DatabaseAuthentication, :count).by(1)
      end

      it "招待を使用済みにすること" do
        post '/users', params: {
          invitation_token: valid_invitation.token,
          user_database_authentication: {
            email: 'newuser@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
        valid_invitation.reload
        expect(valid_invitation.used?).to be true
      end

      it "ユーザーを自動的にログインすること" do
        post '/users', params: {
          invitation_token: valid_invitation.token,
          user_database_authentication: {
            email: 'newuser@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
        follow_redirect!
        expect(response.body).to include('ホーム')
      end

      it "ホーム画面にリダイレクトすること" do
        post '/users', params: {
          invitation_token: valid_invitation.token,
          user_database_authentication: {
            email: 'newuser@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
        expect(response).to redirect_to(root_path)
      end

      it "一般ユーザーとして作成すること" do
        post '/users', params: {
          invitation_token: valid_invitation.token,
          user_database_authentication: {
            email: 'newuser@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
        user = User.last
        expect(user.general?).to be true
      end
    end

    context "バリデーションエラーの場合" do
      it "ユーザーを作成しないこと" do
        expect {
          post '/users', params: {
            invitation_token: valid_invitation.token,
            user_database_authentication: {
              email: 'invalid',
              password: 'short',
              password_confirmation: 'short'
            }
          }
        }.not_to change(User, :count)
      end

      it "フォームを再表示すること" do
        post '/users', params: {
          invitation_token: valid_invitation.token,
          user_database_authentication: {
            email: 'invalid',
            password: 'short',
            password_confirmation: 'short'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('アカウント登録')
      end
    end
  end
end
