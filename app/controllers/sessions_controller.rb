class SessionsController < ApplicationController
  skip_before_action :require_login, expect: [:destoroy]
  
  def new
  end
  
  def create
    if @user = login(params[:session][:email], params[:session][:password]) && current_user.artist == "yes"
      redirect_back_or_to users_show_path, success: 'ログインしました'
    elsif
      @user = login(params[:session][:email], params[:session][:password]) && current_user.artist == "no"
      redirect_back_or_to works_path, success: 'ログインしました'
    else
      flash[:alert] = 'ログイン失敗'
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to(root_path, notice: 'ログアウトしました')
  end
end
