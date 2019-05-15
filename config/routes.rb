Rails.application.routes.draw do
  resources :group_events
  
  namespace :api, defaults: { format: :json }, path: '/api/' do
    namespace :v1 do
      resources :group_events
    end
  end
  
  root 'group_events#index'
end
