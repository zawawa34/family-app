class User::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [ :new, :create ]
  skip_before_action :verify_authenticity_token, if: -> { Rails.env.test? }
  before_action :validate_invitation_token, only: [ :new, :create ]

  # GET /users/sign_up?invitation_token=xxx
  def new
    @invitation = User::Invitation.find_by(token: params[:invitation_token])
    build_resource
    yield resource if block_given?
    respond_with resource
  end

  # POST /users/sign_up
  def create
    @invitation = User::Invitation.find_by(token: params[:invitation_token])

    build_resource(sign_up_params)

    ActiveRecord::Base.transaction do
      # Userを作成（一般ユーザー）
      user = User.new(role: :general)
      user.save!

      # DatabaseAuthenticationを作成してUserに関連付け
      resource.user = user
      resource.save!

      # 招待を使用済みにマーク
      @invitation.mark_as_used!

      # 自動ログイン
      sign_up(resource_name, resource)

      respond_with resource, location: after_sign_up_path_for(resource)
    end
  rescue ActiveRecord::RecordInvalid => e
    clean_up_passwords resource
    set_minimum_password_length
    respond_with resource
  end

  protected

  def validate_invitation_token
    invitation = User::Invitation.find_by(token: params[:invitation_token])

    unless invitation&.valid_invitation?
      flash[:alert] = "招待リンクが無効または期限切れです"
      redirect_to new_user_database_authentication_session_path
    end
  end

  def after_sign_up_path_for(resource)
    root_path
  end
end
