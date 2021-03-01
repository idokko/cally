class WorksController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :destroy, :show, :search]
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_path
    end
  end
  
  def index
    @works = Work.all
    
    @works = @works.joins(:types).where(types: {id: params[:type_id]}) if params[:type_id].present?
  end
  
  def new
    @work = Work.new
  end

  def create
    @work = current_user.works.new(work_params)
    type_list = params[:work_type].split(",")
    if @work.save
      redirect_to works_path, success: '投稿しました'
      @work.save_works(type_list)
    else
      flash.now[:danger] = '投稿できませんでした'
      render :new
    end
  end
  
  def show
    @work = Work.find(params[:id])
    @work_types = @work.types
  end
  
  def destroy
    @work.destroy
    redrect_to new_work_path
  end
  
  def search
    @type_list = Type.all
    @type = Type.find(params[:type_id])
    @works = @type.works.all
  end
  
  private 
  def work_params
    params.require(:work).permit(:image, :title, :description, type_ids: [])
  end
end
