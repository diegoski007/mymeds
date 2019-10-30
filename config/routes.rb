Rails.application.routes.draw do
  resources :medics
  resources :medictasks
  resources :docs
  resources :members
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  patch 'completed_medictasks/:medictask_id', to: 'completed_medictasks#update', as: 'completed_medictask'
  root to: 'docs#index'
end
