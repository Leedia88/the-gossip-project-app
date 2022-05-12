Rails.application.routes.draw do

  get '/', to: 'gossip#index', as: 'root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :gossip  do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end

  resources :messages
  resources :cities
  resources :sessions, only: [:new, :create, :destroy]
  resources :user , except: [:destroy]

  get '/team', to: 'user#team'
  get '/contact', to: 'user#choose_contact'
  get '/welcome/:user_entry', to: 'user#welcome'
  
end
