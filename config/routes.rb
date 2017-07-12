Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  resources :groups, only: [:index, :new, :create, :edit, :update] do
    resource :messages, only: [:create, :show]
  end

  resources :users, only: [] do
    collection do
      get 'search'
    end
  end
end
