class WorksController < ApplicationController
  def index
    @works = Work.all
    
    @works = @works.joins(:types).where(types: {id: params[:type_id]}) if params[:type_id].present?
  end
  
  def new
    @work = Work.new
    # @work.work_type_relations.build
  end

  def create
    @work = current_user.works.new(work_params)
        # binding.pry
    if @work.save
      redirect_to works_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿できませんでした'
      render :new
    end
  end
  
  def show
    @work = Work.find(params[:id])
  end
  def destroy
    @work.destroy
    redrect_to new_work_path
  end
  
  private 
  def work_params
    params.require(:work).permit(:image, :title, :description, type_ids: [])
  end
end
