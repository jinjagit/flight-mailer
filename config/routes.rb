Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'flights#index'
  get  '/list',to: 'flights#list'
  resources :flights
  resources :bookings
end
