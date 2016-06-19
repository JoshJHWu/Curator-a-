Rails.application.routes.draw do
  get '/', to: "dashboard#index"
  get '/search', to: "dashboard#search"

  get '/json', to: "dashboard#json"
end
