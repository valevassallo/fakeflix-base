module Api
    class SeriesController < ApplicationController
        def index
            if params[:filter]
                render json: Serie.where(status: params[:filter])
            else
                render json: Serie.all
            end
        end
        
        def show
            render json: Serie.find(params[:id])
        end

        def update
            serie = Serie.find(params[:id])
            serie[:rating] = params[:rating]
            serie.save
            render json: serie
        end
    end
end