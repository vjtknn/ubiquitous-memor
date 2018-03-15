class CommentsController < ApplicationController


  def create
    @comment = current_user.comments.build(comment_params)
    @comment.movie_id = params[:movie_id]
    if @comment.save
      flash[:notice] = 'Comment has been created'
      redirect_to @comment.movie
    else
      flash[:danger] = "Comment has not been created #{@comment.errors.messages}"
      redirect_to @comment.movie
    end

  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @comment= Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = 'Comment successfully deleted!'
      redirect_to @movie
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
