class SessionsController < ApplicationController
  skip_before_action :require_login, expect: [:destroy]
  
  def new
  end
  
  def create
    if @user = login(params[:session][:email], params[:session][:password]) && current_user.artist == "yes"
      redirect_back_or_to user_path(current_user.id) , success: 'ログインしました'
    elsif
      @user = login(params[:session][:email], params[:session][:password]) && current_user.artist == "no"
      redirect_back_or_to works_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログイン失敗'
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to login_path, danger: 'ログアウトしました'
  end
end
