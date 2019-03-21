Rails.application.routes.draw do
  resources :posts
  # mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: :json } do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations',
          omniauth_callbacks: 'api/v1/auth/omniauth_callbacks'
      }
    end
    namespace :v1 do
      namespace :auth do
        post 'login', to: 'logins#login'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
