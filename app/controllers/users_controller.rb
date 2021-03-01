class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def show
    @user_name = current_user.name
    @works = current_user.works
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :prefectures, :email, :password, :password_confirmation, :artist)
  end
end
