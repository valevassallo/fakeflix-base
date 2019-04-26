require 'rails_helper'

module Api
  describe RentalsController do
    before do
      @movie = Movie.create(
        title: "Peter Pan",
        description: "A kid who never grows up",
        rating: 0,
        price: 20,
        status: "billboard",
        playback: 60
      )
      @serie = Serie.create(
        title: "Supernatural",
        description: "Two brothers fighting against demons",
        rating: 0,
        price: 20,
        status: "billboard"
      )
      @rental = Rental.create(
        paid_price: 45,
        rentable_type: "Movie",
        rentable_id: @movie.id
      )
      @rental1 = Rental.create(
        paid_price: 30,
        rentable_type: "Serie",
        rentable_id: @serie.id
      )
    end
  

    describe 'GET index' do
      it 'returns http status ok' do
        get :index
        expect(response).to have_http_status(:ok)
      end
      it 'render json with all movies and series' do
        get :index
        rentals = JSON.parse(response.body)
        expect(rentals.size).to eq 2
      end
    end

    describe "POST create" do
      it "returns http status created" do
        post :movies, params: {
            paid_price: @movie.price,
            id: @movie.id
        }
        expect(response.status).to eq(201)
        expect(response).to have_http_status(:created)
      end
      it "returns the created @rental" do
        post :series, params: {
            paid_price: @serie.price,
            id: @serie.id
        }
        expected_rental = JSON.parse(response.body)
        expect(expected_rental).to have_key("id")
        expect(expected_rental["paid_price"]).to eq(@serie.price)
      end
    end
  end
end
