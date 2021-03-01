class ApplicationController < ActionController::Base
  before_action :require_login
  
  protected
  def not_authenticated
    redirect_to login_path, alert: "ログインしてください"
  end
  
  protect_from_forgery with: :exception
  
  add_flash_types :success, :info, :warning, :danger
    
end
