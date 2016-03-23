# frozen_string_literal: true
Rails.application.routes.draw do
  apipie
  resources :datasets, only: [:index, :show, :create]
  resources :csv_files, only: [:show, :create]
  resources :data_joins, only: [:create]

  resources :searches, param: :type, only: [:show]
  # mount ActionCable.server => '/cable'
end
