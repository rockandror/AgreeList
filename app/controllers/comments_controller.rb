class CommentsController < ApplicationController
  def create
    @comment = Comment.new(text: params[:comment][:text], individual_id: params[:individual_id], statement_id: params[:statement_id])
    if @comment.save
      redirect_to statement_path(@comment.statement), notice: "Your comment has been created."
    else
      redirect_to statement_path(@comment.statement), notice: "There was an error. Please try again later."
    end
  end
end
