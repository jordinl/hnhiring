Rails.application.routes.draw do
  root to: 'home#show'
  get '/:month', to: 'jobs#index', constraints: { month: /(#{Date::MONTHNAMES.compact.join('|').downcase})-20\d{2}/ }, as: :month
  get '/search', to: 'jobs#search', as: :search
  get '/technologies/:technology', to: 'jobs#keyword', as: :technology
  get '/technologies/:technology/months/:month', to: 'jobs#keyword', as: :technology_month
  get '/locations/:location', to: 'jobs#keyword', as: :location
  get '/locations/:location/months/:month', to: 'jobs#keyword', as: :location_month
  get '/:kind/:keyword/months/:month', to: 'jobs#keyword', as: :keyword_month
  resource :sitemap, only: :show
  resource :robots, only: :show
  resource :contact, only: %i(show create)
end
