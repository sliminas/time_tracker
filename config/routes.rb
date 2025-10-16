# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :working_times, only: %i[index new edit update create destroy] do
    collection do
      delete 'destroy_all'
    end
  end
  resources :day_offs, only: %i[new create]

  # Defines the root path route ("/")
  root 'working_times#index'
end
