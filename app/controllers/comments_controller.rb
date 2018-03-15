class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.movie_id = params[:movie_id]
    if @comment.save
      flash[:notice] = 'Comment has been created'
    else
      flash[:danger] = "Comment has not been created #{@comment.errors.messages}"
    end
    redirect_to @comment.movie
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = 'Comment successfully deleted!'
      redirect_to @movie
    end
  end

  def top_commenters
       @users = User.joins(:comments)
                    .where('comments.created_at >= ?', 1.week.ago.midnight)
                    .select("users.name, count(comments.id) AS comment_count")
                    .group('users.id')
                    .order('comment_count desc')
                    .limit(10)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
