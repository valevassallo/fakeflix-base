module Api
    class MoviesController < ApplicationController
        def index
            if params[:filter]
              render json: Movie.where(status: params[:filter])
            else
              render json: Movie.all
            end
        end
        
        def show
            render json: Movie.find(params[:id])
        end

        def update
            movie = Movie.find(params[:id])
            movie[:playback] = params[:playback]
            movie[:rating] = params[:rating]
            movie.save
            render json: movie
        end
    end
end