Rails.application.routes.draw do
  post '/login', to: 'sessions#create'
  namespace :api do
    resources :movies do
      patch 'playback', on: :member
      patch 'rating', on: :member
    end
    resources :series do
      patch 'rating', on: :member
    end
    resources :episodes do
      patch 'playback', on: :member
    end
    resources :rents, controller: 'rentals', only: [:index] do
      post '/movies/:id' => :movies, on: :collection
      post '/series/:id' => :series, on: :collection
    end
  end
end
