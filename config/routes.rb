Rails.application.routes.draw do

  get 'gossip/:id/likes/create', to: 'likes#create', as: 'likes_create'
  get 'gossip/:id/likes/destroy', to: 'likes#destroy', as: 'likes_destroy'
  get '/', to: 'gossip#index', as: 'root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :gossip  do
    resources :comments
  end
  resources :messages
  resources :cities
  resources :sessions, only: [:new, :create, :destroy]
  resources :user , except: [:destroy]

  get '/team', to: 'user#team'
  get '/contact', to: 'user#choose_contact'
  get '/welcome/:user_entry', to: 'user#welcome'
  
end
