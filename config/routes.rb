Rails.application.routes.draw do
  namespace :api do
    resources :movies, only: [:index, :show, :update] do
      patch 'playback', on: :member
      patch 'rating', on: :member
    end
    resources :series, only: [:index, :show, :update] do
      patch 'rating', on: :member
    end
    resources :episodes, only: [:show, :update] do
      patch 'playback', on: :member
    end
    resources :rents, controller: 'rentals', only: [:index] do
      post '/movies/:id' => :movies, on: :collection
      post '/series/:id' => :series, on: :collection
    end
  end
end
