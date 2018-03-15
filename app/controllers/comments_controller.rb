class CommentsController < ApplicationController

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
