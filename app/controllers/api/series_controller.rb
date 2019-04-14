module Api
    class SeriesController < ApplicationController
        def index
            if params[:filter]
                @series = Serie.where(status: params[:filter])
            else
                @series = Serie.all
            end
            render json: @series.as_json(methods: [:rented?], include: {episodes: {only: [:id, :title]}})
        end
        
        def show
            @series = Serie.find(params[:id])
            render json: @series.as_json(methods: [:rented?, :progress], include: {episodes: {only: [:id, :title]}})
        end

        def rating
            serie = Serie.find(params[:id])
            serie[:rating] = params[:rating]
            serie.save
            render json: serie
        end
    end
end