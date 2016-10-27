Rails.application.routes.draw do
  namespace :api do
    resources :alexa_utterances
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"
end
