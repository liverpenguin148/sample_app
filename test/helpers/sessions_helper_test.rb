require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  
  def setup
    # fixtureにあるtakaを定義
    @user = users(:taka)
    # rememberメソッドで記憶
    remember(@user)
  end
  
  test "current_user returns right user when session is nil" do
    # current_userをtakaが同じか
    assert_equal @user, current_user
    # テストユーザーがログイン中か
    assert is_logged_in?
  end
  
  test "current_user return nil when remember digest is wrong" do
    # @userの記憶ダイジェストが、ハッシュ化した記憶トークンを暗号化した値と同じなら、
    # 記憶ダイジェストを更新
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    # 現在のユーザーがnilならtrue
    # (@userが更新できない場合、現在のユーザーがnilになるかどうか検証)
    assert_nil current_user
  end
end