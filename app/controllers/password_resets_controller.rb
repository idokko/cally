class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  
  #パスワードリセット申請フォーム用
  def new;
  end

  # パスワードリセットをリクエスト
  def create
    @user = User.find_by(email: params[:email])
    # DBからデータを受け取っていれば、
    # パスワードリセットの方法を記載したメールをユーザーに送信する
    # @uaer.deliver_reset_password_instructions! if @user と同じ
    if @user
      @user.deliver_reset_password_instructions!
      redirect_to login_path, success: "メールを送信しました"
    else
      redirect_to login_path, danger: "メールを送信できませんでした"
    end
  end

  # パスワードリセットフォームのページへ遷移
  def edit
    @token = params[:id]
    # リクエストで送信されてきたトークンを使って、ユーザー検索を行う
    # トークンが見つかり有効であれば、ユーザーオブジェクトを@userに格納する
    @user = User.load_from_reset_password_token(@token)
    # @userがnilまたは空の場合、not_authenticatedメソッドを実行する
    return not_authenticated if @user.blank?
  end

  # ユーザーがパスワードのリセットフォームを送信した時に実行
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    return not_authenticatriond if @user.blank?
    @user.password_confirmation = params[:user][:password_confirmation]
    # change_passwordメソッドでパスワードリセットに使用したトークンを削除し、
    # パスワードを更新する
    if @user.change_password!(params[:user][:password])
      redirect_to login_path, success: "パスワードを更新しました"
    else
      flash.now[:danger] = "更新できませんでした"
      render :edit
    end
  end
end