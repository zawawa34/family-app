require 'rails_helper'

RSpec.describe "User::Invitations", type: :request do
  let(:admin_user) { create(:user, :admin) }
  let(:admin_auth) { create(:database_authentication, user: admin_user, email: 'admin@example.com', password: 'password123', password_confirmation: 'password123') }
  let(:general_user) { create(:user, :general) }
  let(:general_auth) { create(:database_authentication, user: general_user, email: 'general@example.com', password: 'password123', password_confirmation: 'password123') }

  describe "GET /invitations" do
    context "管理者としてログインしている場合" do
      before do
        sign_in admin_auth
        create(:invitation, create_user: admin_user)
        create(:invitation, create_user: admin_user)
      end

      it "招待一覧を表示すること" do
        get '/invitations'
        expect(response).to have_http_status(:success)
      end

      it "自分が作成した招待のみを表示すること" do
        other_admin = create(:user, :admin)
        other_invitation = create(:invitation, create_user: other_admin)

        get '/invitations'
        expect(response.body).not_to include(other_invitation.token)
      end
    end

    context "一般ユーザーとしてログインしている場合" do
      before do
        sign_in general_auth
      end

      it "アクセスを拒否すること" do
        get '/invitations'
        expect(response).to redirect_to(root_path)
      end

      it "エラーメッセージを表示すること" do
        get '/invitations'
        follow_redirect!
        expect(response.body).to include('管理者のみアクセスできます')
      end
    end

    context "未ログインの場合" do
      it "ログインページにリダイレクトすること" do
        get '/invitations'
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe "POST /invitations" do
    context "管理者としてログインしている場合" do
      before do
        sign_in admin_auth
      end

      it "招待を作成すること" do
        expect {
          post '/invitations'
        }.to change(User::Invitation, :count).by(1)
      end

      it "招待トークンを自動生成すること" do
        post '/invitations'
        invitation = User::Invitation.last
        expect(invitation.token).not_to be_nil
        expect(invitation.token.length).to be >= 20
      end

      it "有効期限を7日後に設定すること" do
        post '/invitations'
        invitation = User::Invitation.last
        expect(invitation.expires_at).to be_within(1.second).of(7.days.from_now)
      end

      it "ステータスをunusedに設定すること" do
        post '/invitations'
        invitation = User::Invitation.last
        expect(invitation.unused?).to be true
      end

      it "現在のユーザーをcreate_userに設定すること" do
        post '/invitations'
        invitation = User::Invitation.last
        expect(invitation.create_user).to eq(admin_user)
      end

      it "招待一覧ページにリダイレクトすること" do
        post '/invitations'
        expect(response).to redirect_to('/invitations')
      end
    end

    context "一般ユーザーとしてログインしている場合" do
      before do
        sign_in general_auth
      end

      it "招待を作成しないこと" do
        expect {
          post '/invitations'
        }.not_to change(User::Invitation, :count)
      end

      it "アクセスを拒否すること" do
        post '/invitations'
        expect(response).to redirect_to(root_path)
      end
    end

    context "未ログインの場合" do
      it "ログインページにリダイレクトすること" do
        post '/invitations'
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
