Rails.application.routes.draw do
  devise_for :users
  root "messages#index"
  get 'groups/new' => 'groups#new'
end
