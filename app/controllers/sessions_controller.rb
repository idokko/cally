class SessionsController < ApplicationController
  # skip_before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
  end
  
  def create
    if @user = login(params[:name], params[:password])
      redirect_back_or_to(login_path, success: 'ログインしました')
    else
      flash[:alert] = 'ログイン失敗'
      render :new
    end
  end
  
  def destory
    logout
    redirect_to(root_path, notice: 'ログアウトしました')
  end
end
