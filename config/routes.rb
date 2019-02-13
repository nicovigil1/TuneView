Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: "welcome#index", as: 'home'

  get '/auth/spotify/callback', to: 'sessions#create'

  get '/dashboard', to: "users#show", as: "dashboard"
end
