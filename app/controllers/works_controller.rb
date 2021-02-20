class WorksController < ApplicationController
  def index
    @works = Work.all
    # binding.pry
    
    @works = @works.joins(:types).where(types: {id: params[:type_id]}) if params[:type_id].present?
    # @type_list = Type.all
    # @work = current_user.works.new
  end
  
  def new
    @work = Work.new
    # @work.work_type_relations.build
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
