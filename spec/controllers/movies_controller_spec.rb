require 'rails_helper'

module Api
  describe MoviesController do
    before do
      @movie = Movie.create(
          title: "Peter Pan",
          description: "A kid who never grows up",
          rating: 0,
          price: 20,
          status: "billboard",
          playback: 60
      )
    end
    describe 'GET index' do
      it 'returns http status ok' do
          get :index, params: { filter: @movie.status }
          expect(response).to have_http_status(:ok)
      end
      it 'render json with all movies' do
          get :index
          movies = JSON.parse(response.body)
          expect(movies.size).to eq 1
      end
    end

    describe 'GET show' do
      it 'returns http status ok' do
          get :show, params: { id: @movie }
          expect(response).to have_http_status(:ok)
      end
      it 'render the correct @movie' do
          get :show, params: { id: @movie }
          expected_movie = JSON.parse(response.body)
          expect(expected_movie["id"]).to eq(@movie.id)
      end
    end

    describe "PATCH update" do
      it "returns http status ok" do
        patch :update, params: { 
          id: @movie, 
          playback: 120,
          rating: 1
          }
        expect(response).to have_http_status(:ok)
      end
      it "returns the updated @movie" do
        patch :update, params: { 
          id: @movie, 
          playback: 120,
          rating: 1
          }
        expected_movie = JSON.parse(response.body)
        expect(expected_movie["playback"]).to eq(120)
        expect(expected_movie["rating"]).to eq(1)
      end
    end
  end
end