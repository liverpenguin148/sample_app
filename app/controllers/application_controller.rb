class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #CSRF対策
  
  def hello
    render html: "hello,world"
  end
end
