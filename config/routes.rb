Rails.application.routes.draw do
  get 'scaffold/StaticPages'
  get 'scaffold/home'
  get 'scaffold/help'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
