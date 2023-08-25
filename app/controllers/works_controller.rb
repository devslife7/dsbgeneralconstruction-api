class WorksController < ApplicationController
  def index
    workList = Work.all
    render json: workList, except: [:created_at, :updated_at]
  end

  def show
    work = Work.find(params[:id])

    if work.valid?
      render json: work, except: [:created_at, :updated_at], include: [:comments]
    else
      render json: { error: { message: "Task could not be found" } }
    end
  end

  def update
    work = Work.find(params[:id])

    if work.update(update_work_params)
      render json: { work: work }, status: :ok
    else
      render json: { error: { message: "Server was not able to update new Work" } }, status: :unprocessable_entity
    end
  end

  def update_rating
    work = Work.find(params[:id])

    if work
      ratingList = []
      ratingList = work.ratings.push(params[:rating])

      work.update(ratings: ratingList)
      render json: { work: work }, status: :ok
    else
      render json: { error: { message: "Server was not able to find Work" } }, status: :unprocessable_entity
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

  def create
    work = Work.new(title: params[:title], description: params[:description])
    if work.save
      work.images.attach(params["images"])

      imageList = []

      work.images.map do |image|
        imageList << url_for(image)
      end

      work.update(image_urls: imageList)
      render json: { work: work }, status: :created
    else
      render json: { error: { message: "Server was not able to create new Work" } }, status: :unprocessable_entity
    end
  end

  # uploads the avatar to Work
  def upload_files
    work = Work.find_by(id: params[:id])
    if work
      # work.images.purge
      work.images.attach(params[:images])

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

  def update_work_params
    params.require(:work).permit(:title, :description, :rating)
  end
end
