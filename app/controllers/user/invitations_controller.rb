class User::InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @invitations = current_user.invitations.order(created_at: :desc)
  end

  def create
    @invitation = current_user.invitations.build

    if @invitation.save
      redirect_to invitations_path, notice: '招待リンクを作成しました'
    else
      redirect_to invitations_path, alert: '招待リンクの作成に失敗しました'
    end
  end

  private

  def require_admin!
    unless current_user.admin?
      flash[:alert] = '管理者のみアクセスできます'
      redirect_to root_path
    end
  end
end
