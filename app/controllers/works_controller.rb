class WorksController < ApplicationController
  before_action :require_login, only: [:index, :new, :create, :destroy, :show, :search]
  
  def index
    @works = Work.all
    
    @works = @works.joins(:types).where(types: {id: params[:type_id]}) if params[:type_id].present?
  end
  
  def new
    @work = Work.new
  end

  def create
    @work = current_user.works.new(work_params)
    # binding.pry
    # type_list = params[:work_type].split(",")
    if @work.save
      redirect_to user_path(current_user.id), success: '投稿しました' and return
      # @work.save
    else
      # flash.now[:danger] = '投稿できませんでした'
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
