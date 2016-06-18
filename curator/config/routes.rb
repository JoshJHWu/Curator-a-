Rails.application.routes.draw do
  get '/', to: "dashboard#index"
  get '/search', to: "dashboard#initialize"
end
