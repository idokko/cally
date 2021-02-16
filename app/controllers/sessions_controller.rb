class SessionsController < ApplicationController
  # skip_before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
  end
  
  def create
    # binding.pry
    if @user = login(params[:session][:email], params[:session][:password])
    # if @user = login(params[:session][:email], params[:session][:password]) && User.params[:artist] == :yes
      redirect_back_or_to works_path, success: 'ログインしました'
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
