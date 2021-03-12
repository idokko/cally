class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]
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
      # flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def show
    # binding.pry
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
  
  private
  def user_params
    params.require(:user).permit(:name, :prefectures, :email, :password, :password_confirmation, :artist)
  end
end
