require 'rails_helper'

module Api
    describe SeriesController do
        before do
            @serie = Serie.create(
                title: "Supernatural",
                description: "Two brothers fighting against demons",
                rating: 0,
                price: 20,
                status: "billboard"
            )
        end
        describe 'GET index' do
            it 'returns http status ok' do
                get :index, params: { filter: @serie.status }
                expect(response).to have_http_status(:ok)
            end
            it 'render json with all series' do
                get :index
                series = JSON.parse(response.body)
                expect(series.size).to eq 1
            end
        end

        describe 'GET show' do
            it 'returns http status ok' do
                get :show, params: { id: @serie }
                expect(response).to have_http_status(:ok)
            end
            it 'render the correct @serie' do
                get :show, params: { id: @serie }
                expected_serie = JSON.parse(response.body)
                expect(expected_serie["id"]).to eq(@serie.id)
            end
        end

        describe "PATCH update" do
            it "returns http status ok" do
                patch :update, params: { 
                    id: @serie,
                    rating: 1
                    }
                expect(response).to have_http_status(:ok)
            end
            it "returns the updated @serie" do
                patch :update, params: { 
                    id: @serie,
                    rating: 1
                    }
                expected_serie = JSON.parse(response.body)
                expect(expected_serie["rating"]).to eq(1)
            end
        end
    end
end