module SessionsHelper
  #渡されたユーザーでログイン(セッションでuser_idを持つ)
  # ⇒ セッションでuser_idを持っている = ログイン状態
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 現在ログイン中のユーザーを返す。
  def current_user
    # ||= @currenc_user が nil(又はfalse) の場合、
    # セッションのuser_idを元にDBを検索し、値を代入
    if session[:user_id]
      @current_user ||= User.find_by(id:session[:user_id])
    end
  end
  # ユーザーがログインしていれば、true、その他ならfalseを返す。
  def logged_in?
    !current_user.nil?
  end
end
