class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    #パスワード認証
    if user && user.authenticate(params[:session][:password])
      # helperのメソッドを呼ぶ(セッションにuser_idを保持)
      log_in(user)
      redirect_to user
    else
      #flash.now ⇒ 次のアクションに移行した時点で消える
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end
