module Api
  class RentalsController < ApplicationController
    def index
      authorize(Rental)
      render json: Rental.all
    end

    def show
      @rental = Rental.find(params[:id])
      authorize(Rental)
    end

    def movies
      movie = Movie.find(params[:id])
      rental = movie.rentals.create(
          paid_price: movie.price
      )
      render json: rental, status: :created
    end

    def series
      serie = Serie.find(params[:id])
      rental = serie.rentals.create(
          paid_price: serie.price
      )
      render json: rental, status: :created
    end

    def create
      authorize(Rental)
      @rental = Rental.new(rental_params)
      if @rental.save
        render json: @rental, status: :ok
      else
        render json: @rental.errors, status: :unprocessable_entity
      end
    end
    
    def update
      authorize(Rental)
      if @rental.update(rental_params)
        render json: @rental, status: :ok
      else
        render json: @rental.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      authorize(Rental)
      @rental.destroy
      render nothing: true, status: :no_content
    end
  
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    private

    def rental_params
      params.permit(:paid_price, :rentable_type, :rentable_id)
    end
  end
end