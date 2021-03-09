class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
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
    @user_id = User.find(params[:id])
    # チャット
    # Entry内のuser_idがcurrent_userと同じEntry
    @current_user_entry = Entry.where(user_id: current_user.id)
    # Entry内のuser_idがMYPAGEのparams.idと同じEntry
    @user_entry = Entry.where(user_id: @user_id.id)
    # user_id.idとcurrent_user.idが同じでなければ
    unless @user_id.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          # もしcurrent_user側のルームidと@user側のルームidが同じであれば存在する
          if cu.room_id == u.room_id then
            @is_room = true
            @room_id = cu.room_id
          end
        end
      end
      # ルームが存在してなければ、ルームとエントリーを作成する
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
    
    # 自分の作品一覧
    @user_name = current_user.name
    @works = @user_id.works
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :prefectures, :email, :password, :password_confirmation, :artist)
  end
end
