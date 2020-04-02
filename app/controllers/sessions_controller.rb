class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    #パスワード認証
    if user && user.authenticate(params[:session][:password])
      # helperのメソッドを呼ぶ(セッションにuser_idを保持)
      log_in user
      # チェックボックスの送信結果処理
      # sessionのremember_meが "1" の場合、remember(user)、そうでない場合、forget(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # ランダムなトークンを作成、その値をハッシュ化した値(記憶ダイジェスト)をDB保存
      redirect_back_or user
    else
      #flash.now：次のアクションに移行した時点で消える
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
