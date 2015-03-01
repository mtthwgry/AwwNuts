class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comments = Comment.all
    @comment = Comment.new(comment_params)
    @comment.author = User.find(current_user.id)

    if @comment.save
      render :_show, locals: { comment: @comment, comments: @comments }, layout: false
    else
      @error = @comment.errors
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def context
    if params[:question_id]
      id = params[:question_id]
      Question.find(params[:question_id])
    else
      id = params[:answer_id]
      Answer.find(params[:answer_id])
    end
  end 

  def context_url(context)
    if Question === context
      question_path(context)
    else
      answer_path(context)
    end
  end
end
