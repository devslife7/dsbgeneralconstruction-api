class CommentsController < ApplicationController
  def index
    comments = Comment.all
    render json: { comments: comments }
  end

  def show
    comment = Comment.find(params[:id])

    if comment.valid?
      render json: comment
    else
      render json: { error: { message: "Comment could not be found with given id." } }
    end
  end

  def create
    work = Work.find_by(id: comment_params[:work_id])

    if !work
      render json: { error: { message: "User could not be found with given id." } }
    else
      comment = Comment.new(comment_params)

      if comment.save
        # debugger
        render json: work, include: [:comments], status: :created
      else
        render json: { error: { message: "Server was not able to create new Comment." } }, status: :unprocessable_entity
      end
    end
  end

  def update
    comment = Comment.find(params[:id])

    if comment.update(comment_params)
      render json: { comment: comment }, status: :ok
    else
      render json: { error: { message: "Server was not able to update Comment." } }, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])

    if comment
      comment.destroy
      render json: { message: "Comment was removed succesfully.", comment: comment }
    else
      render json: { error: { message: "Comment could not be found with given id." } }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:username, :content, :work_id)
  end
end
