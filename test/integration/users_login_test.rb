require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  #テストユーザーの設定
  def setup
    # ユーザー用のfixtureのファイル名 users.ymlの :takaシンボルを参照
    @user = users(:taka)
  end
  
  test "login with invalid information" do
    # get送信 login_path
    get login_path
    
    # 指定されたテンプレートが選択されたか
    assert_template 'sessions/new'
    # email: "" , password: "" でpost送信
    post login_path, params: { session: { email: "", password: "" }}
    # ログインできないので、ログインページへ遷移
    assert_template 'sessions/new'
    # flashメッセージが表示されているか
    assert_not flash.empty?
    # rootページへ
    get root_path
    # flashメッセージが表示されているか
    assert flash.empty?
  end
  
  test "login with valid information followed by logout" do
    # ログイン用ページの表示(get送信)
    get login_path
    # ログイン(有効な情報)
    post login_path, params: { session: { email: @user.email, password: "password"}}
    # テストユーザーがログイン中かどうか
    assert is_logged_in?
    #リダイレクト先が正しいか
    assert_redirected_to @user
    # そのページへ移動
    follow_redirect!
    assert_template 'users/show'
    # a href タグの存在チェック
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    # ログアウト用
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
