# frozen_string_literal: true
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :datasets, only: [:index, :show, :create]
  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
