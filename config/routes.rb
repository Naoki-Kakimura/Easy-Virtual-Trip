Rails.application.routes.draw do
  root "plans#index"
  resources :plans, only:[:index,:new,:create]
end
