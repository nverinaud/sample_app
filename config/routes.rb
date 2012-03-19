SampleApp::Application.routes.draw do

  root to: 'static_pages#home'

  # Users & Sessions
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'

  # Static Pages
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  # Resources
  resources :users do
    member do # Allow URI like /users/1/followers to get the followers of user 1
      get :followers, :following
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :follow_relationships, only: [:create, :destroy]

end