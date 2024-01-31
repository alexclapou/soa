Rails.application.routes.draw do
  resources :todos
  post "tokens", to: "refresh_tokens#create" 
  post "tokens/refresh", to: "refresh_tokens#refresh" 
end
