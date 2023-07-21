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

  def create
    work = Work.new(work_params)

    if work.save
      render json: work, status: :created
    else
      render json: { message: "Server was not able to create new Work" }, status: :unprocessable_entity
    end
  end

  def update
    work = Work.find(params[:id])

    if work.update(work_params)
      render json: work
    else
      render json: { message: "Server was not able to update new Work" }, status: :unprocessable_entity
    end
  end

  def destroy
    work = Work.find(params[:id])
    work.destroy
    head :no_content
  end

  private

  def work_params
    params.require(:work).permit(:title, :description)
  end
end
