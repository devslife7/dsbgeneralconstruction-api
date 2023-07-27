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
      render json: { error: { message: "Task could not be found" } }
    end
  end

  def create
    # debugger
    work = Work.new(work_params)

    if work.save
      # work.images.attach(params["images"])

      # imageList = []
      # work.images.map do |image|
      #   imageList << url_for(image)
      # end

      # work.update(image_urls: imageList)

      render json: { work: work }, status: :created
    else
      render json: { error: { message: "Server was not able to create new Work" } }, status: :unprocessable_entity
    end
  end

  def update
    work = Work.find(params[:id])

    if work.update(work_params)
      render json: { work: work }, status: :ok
    else
      render json: { error: { message: "Server was not able to update new Work" } }, status: :unprocessable_entity
    end
  end

  def destroy
    work = Work.find(params[:id])

    if work
      work.destroy

      render json: { work: work }
    else
      render json: { error: { message: "Work could not be found with given id" } }
    end
  end

  # uploads the avatar to User
  def upload_files
    work = Work.find_by(id: params[:id])

    if work
      # work.images.purge

      work.images.attach(params["images"])

      imageList = []

      work.images.map do |image|
        imageList << url_for(image)
      end

      work.update(image_urls: imageList)

      render json: { work: work }
    else
      render json: { message: "user could not be found" }
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :description)
  end

  def update_work_params
    params.require(:work).permit(:title, :description, :images[])
  end
end
