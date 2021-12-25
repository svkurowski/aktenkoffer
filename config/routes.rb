Rails.application.routes.draw do
  resources :api_keys
  root 'documents#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :documents
  resources :contacts, except: :show

  namespace 'api' do
    resources :documents, only: :create
  end
end
