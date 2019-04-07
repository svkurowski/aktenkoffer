Rails.application.routes.draw do
  root 'documents#index'

  resources :documents
  resources :contacts, except: :show

  namespace 'api' do
    resources :documents, only: :create
  end
end
