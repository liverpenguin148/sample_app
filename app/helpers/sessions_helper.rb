module SessionsHelper
  #渡されたユーザーでログイン(セッションでuser_idを持つ)
  # ⇒ セッションでuser_idを持っている = ログイン状態
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # ユーザーのセッションを永続的にする
  def remember(user)
    # user.rbのrememberメソッドを呼ぶ
    user.remember
    # cookiesへの保存
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    # ユーザーIDのセッションが存在する場合
    if (user_id = session[:user_id])
      # ||= @currenc_user が nil(又はfalse) の場合、 セッションのuser_idを元にDBを検索し、値を代入
      @current_user ||= User.find_by(id: user_id)
    # ユーザーIDのcookiesが存在する場合
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # 現在のユーザーをログアウト
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
