Rails.application.routes.draw do
  root "plans#index"
  resources :plans, only:[:index,:new,:create]
  resources :maps, only:[:new,:create]
  resources :streets, only:[:new,:create]
  resources :weathers, only:[:index]
end
