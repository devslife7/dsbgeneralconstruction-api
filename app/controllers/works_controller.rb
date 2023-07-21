class WorksController < ApplicationController
  def index
    workList = Work.all
    render json: workList
  end

  def show
    work = Work.find(params[:id])

    if work.valid?
      render json: work
    else
      render json: { error: "Task could not be found" }
    end
  end

  #   private

  #   def user_params
  #     params.require(:user).permit(:name, :email)
  #   end
end
