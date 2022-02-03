Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :api_keys
  root 'documents#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :documents
  resources :contacts, except: :show

  namespace 'api' do
    resources :documents, only: :create
  end
end
