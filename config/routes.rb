Democracy::Application.routes.draw do
  devise_for :users

  resources :categories do
    resources :proposals do
      resources :comments
      resources :votes
    end
  end

  root :to => "dashboard#index"
end
