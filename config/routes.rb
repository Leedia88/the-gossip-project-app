Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'gossip#index'

  resources :gossip
  resources :user

  get '/team', to: 'user#team'
  get '/contact', to: 'user#choose_contact'
  get '/contactform', to: 'user#contact'
  get '/welcome/:user_entry', to: 'user#welcome'


end
