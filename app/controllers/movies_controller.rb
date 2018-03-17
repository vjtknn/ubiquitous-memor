class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.eager_load(comments: :user).find(params[:id]).decorate
    @comments = @movie.comments.order('created_at DESC').decorate
    @comment = @movie.comments.build
    if current_user
      @current_user_movie_comments_id = current_user.comments.pluck(:movie_id)
    end
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_to :back, notice: "Email sent with movie info"
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end
