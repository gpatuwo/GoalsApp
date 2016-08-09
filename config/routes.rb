Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show, :index] do
    resources :goals, only: :index
  end

  resources :goals, except: :index

  resource :session, only: [:new, :create, :destroy]


end
