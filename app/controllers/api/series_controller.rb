module Api
    class SeriesController < ApplicationController
        def index
            if params[:filter]
                @series = Serie.where(status: params[:filter])
            else
                @series = Serie.all
            end
            render json: @series.as_json(methods: [:rented?])
        end
        
        def show
            @series = Serie.find(params[:id])
            render json: @series.as_json(methods: [:rented?, :progress])
        end

        def update
            serie = Serie.find(params[:id])
            serie[:rating] = params[:rating]
            serie.save
            render json: serie
        end
    end
end