Rails.application.routes.draw do
  devise_for :users
  root "messages#index"
  resources :groups, only: [:new, :create, :edit, :update] do
    resource :messages, only: [:create, :show]
  end
end
