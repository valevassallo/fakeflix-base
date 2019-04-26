module Api
  class MoviesController < ApplicationController
    def index
      authorize(Movie)
      if params[:filter]
        @movies = Movie.where(status: params[:filter])
      else
        @movies = Movie.all
      end
      render json: @movies.as_json(methods: [:rented?])
    end
    
    def show
      render json: Movie.find(params[:id])
      authorize(Movie)
    end

    def playback
      @movie = Movie.find(params[:id])
      movie[:playback] = params[:playback]
      @movie.save
      render json: movie
    end

    def rating
      @movie = Movie.find(params[:id])
      movie[:rating] = params[:rating]
      @movie.save
      render json: movie
    end

    def create
      authorize(Movie)
      @movie = Movie.new(movie_params)
      if @movie.save
        render json: @movie, status: :ok
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
    end
    
    def update
      authorize(Movie)
      @movie = Movie.find(params[:id])
      if @movie.update(movie_params)
        render json: @movie, status: :ok
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      authorize(Movie)
      @movie = Movie.find(params[:id])
      @movie.destroy
      render nothing: true, status: :no_content
    end
    
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end
    
    private

    def movie_params
      params.permit(:title ,:description ,:rating ,:duration ,:price ,:status ,:progress)
    end
  end
end