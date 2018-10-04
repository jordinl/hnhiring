Rails.application.routes.draw do
  root to: 'home#show'
  get '/:id', to: 'months#show', constraints: { id: /(#{Date::MONTHNAMES.compact.join('|').downcase})-20\d{2}/ }, as: :month
end
