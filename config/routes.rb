Hnhiring::Application.routes.draw do

  root to: "home#show"
  resources :months, only: [:show]

end
