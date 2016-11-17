Rails.application.routes.draw do
  
  resources :lessons
  resources :posts
  PagesController.action_methods.each do |action|
    get "/#{action}", to: "pages##{action}", as: "#{action}_page"
  end

  root to: "pages#home"
end
