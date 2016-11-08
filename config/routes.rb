Rails.application.routes.draw do
  
  PagesController.action_methods.each do |action|
    get "/#{action}", to: "pages##{action}", as: "#{action}_page"
  end

  root to: "pages#home"
end
