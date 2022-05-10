Rails.application.routes.draw do
  get 'message/index'
  get 'message/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'gossip#index'

  resources :gossip , except: [:destroy] do
    resources :comment
  end

  resources :user , except: [:destroy]

  get '/search', to: 'gossip#search'
  get '/team', to: 'user#team'
  get '/contact', to: 'user#choose_contact'
  get '/welcome/:user_entry', to: 'user#welcome'



end
