Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'managers/registrations',
    invitations: 'managers/invitations'
  }

  scope path: '/dashboard' do
    resources :features
    resources :plans do
      resources :subscriptions, controller: :subscriptions, shallow: true
    end

    scope module: :managers do
      get '/', to: 'dashboard#index'
      get '/invitees', to: 'dashboard#invitees', as: :invitees
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
