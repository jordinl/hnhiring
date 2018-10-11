Rails.application.routes.draw do
  root to: 'home#show'
  get '/:month', to: 'jobs#index', constraints: { month: /(#{Date::MONTHNAMES.compact.join('|').downcase})-20\d{2}/ }, as: :month
  get '/search', to: 'jobs#search', as: :search
  get '/technologies/:technology', to: 'jobs#technology', as: :technology
  get '/technologies/:technology/months/:month', to: 'jobs#technology', as: :technology_month
  resource :sitemap, only: :show
  resource :robots, only: :show
end
