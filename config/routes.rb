Rails.application.routes.draw do
  root 'documents#index'

  resources :documents
  resources :contacts, except: :show
end
