Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post :charges, to: 'charges#create'
  post :add_card, to: 'charges#add_card'
  # devise_for :users
  # resources :posts
  # root to: 'posts#index'
end
