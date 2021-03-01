class Admin::UsersController < ApplicationController
    before_action :admin_user
    
    def index
       @users = User.all.order(created_at: :desc) 
    end
    
    def show
        
    end
    
    private
    def admin_user
        redirect_to (root_path) unless current_user.admin? 
    end
end
