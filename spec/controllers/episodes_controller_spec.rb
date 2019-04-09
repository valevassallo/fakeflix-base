require 'rails_helper'

module Api
    describe EpisodesController do
        before do
            @serie = Serie.create(
                title: "Supernatural",
                description: "Two brothers fighting against demons",
                rating: 0,
                price: 20,
                status: "billboard"
            )
            @episode = Episode.create(
                title: "The French Mistake",
                description: "Sam and Dean go to the real world",
                duration: 49,
                serie_id: @serie.id,
                playback: 300
            )
        end
        describe 'GET show' do
            it 'returns http status ok' do
                get :show, params: { id: @episode }
                expect(response).to have_http_status(:ok)
            end
            it 'render the correct @episode' do
                get :show, params: { id: @episode }
                expected_episode = JSON.parse(response.body)
                expect(expected_episode["id"]).to eq(@episode.id)
            end
        end

        describe "PATCH update" do
            it "returns http status ok" do
                patch :update, params: { 
                    id: @episode, 
                    playback: 360
                    }
                expect(response).to have_http_status(:ok)
            end
            it "returns the updated @episode" do
                patch :update, params: { 
                    id: @episode, 
                    playback: 360
                    }
                expected_episode = JSON.parse(response.body)
                expect(expected_episode["playback"]).to eq(360)
            end
        end
    end
end