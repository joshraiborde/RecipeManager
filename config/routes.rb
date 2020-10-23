Rails.application.routes.draw do
  # Category, Ingredient, Rating, Recipe Ingredient, Recipe, User, Login/Out
  root to: redirect('/categories')
  resources :categories do
    resources :recipes do
      resources :ratings, only: %i[new create]
    end
  end
  resources :ingredients
  resource :user, only: %i[new create show] 
  resource :session, only: %i[new create delete]
end
