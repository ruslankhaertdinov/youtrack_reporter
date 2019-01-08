Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  # root to: "pages#home"
  resources :reports, only: %i[new create]
  root to: 'reports#new'
end
