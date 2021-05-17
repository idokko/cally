class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create, :show]
  before_action :set_user, only: %i[edit update destroy]
  
  def index
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: '登録が完了しました'
    else
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    # 自分が参加しているメッセージルームの情報を取得する
    @currentUserEntry = Entry.where(user_id: current_user.id)
    # 選択したユーザーのメッセージルームの情報を取得する
    @userEntry = Entry.where(user_id: @user.id)
    
    # current_userと選択したユーザー間に共通のメッセージルームがあれば、フラグを立てる
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      # 無ければ作成する
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
      
    # 自分の作品一覧
    @user_name = current_user.name
    @works = @user.works
  end
  
  def edit
      @uer = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(edit_user_params)
      redirect_to user_path(current_user.id), success: 'プロフィールを更新しました'
    else
      render :edit
    end
  end
  
  private
  def set_user
    @user = User.find(current_user.id)
  end
  
  def user_params
    params.require(:user).permit(:name, :prefectures, :email, :password, :password_confirmation, :artist, :profile_image, :profile_image_cache, :profile)
  end
  
  def edit_user_params
    params.require(:user).permit(:name, :prefectures, :email, :artist, :profile_image, :profile)
  end
end
