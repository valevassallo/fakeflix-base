module Api
    class MoviesController < ApplicationController
        def index
            if params[:filter]
              @movies = Movie.where(status: params[:filter])
            else
              @movies = Movie.all
            end
            render json: @movies.as_json(methods: [:rented?])
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