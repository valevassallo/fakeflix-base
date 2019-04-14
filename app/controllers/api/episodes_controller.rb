module Api
    class EpisodesController < ApplicationController
        def show
            render json: Episode.find(params[:id])
        end

        def playback
            episode = Episode.find(params[:id])
            episode[:playback] = params[:playback]
            episode.save
            render json: episode
        end
    end
end