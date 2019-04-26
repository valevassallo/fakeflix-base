module Api
  class SeriesController < ApplicationController
    def index
      authorize(Serie)
      if params[:filter]
        @series = Serie.where(status: params[:filter])
      else
        @series = Serie.all
      end
      render json: @series.as_json(methods: [:rented?], include: {episodes: {only: [:id, :title]}})
    end
    
    def show
      @series = Serie.find(params[:id])
      authorize(Serie)
      render json: @series.as_json(methods: [:rented?, :progress], include: {episodes: {only: [:id, :title]}})
    end

    def rating
      serie = Serie.find(params[:id])
      serie[:rating] = params[:rating]
      serie.save
      render json: serie
    end

    def create
      authorize(Serie)
      @serie = Serie.new(serie_params)
      if @serie.save
        render json: @serie, status: :ok
      else
        render json: @serie.errors, status: :unprocessable_entity
      end
    end
    
    def update
      authorize(Serie)
      @series = Serie.find(params[:id])
      if @serie.update(serie_params)
        render json: @serie, status: :ok
      else
        render json: @serie.errors, status: :unprocessable_entity
      end
    end
    
    def destroy
      authorize(Serie)
      @series = Serie.find(params[:id])
      @serie.destroy
      render nothing: true, status: :no_content
    end
  
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    private

    def serie_params
      params.permit(:title ,:description ,:rating , :price ,:status)
    end
  end
end