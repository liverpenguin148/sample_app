require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:taka)
    @other_user = users(:archer)
  end
  
  test "should redirect index when not logged_in" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when not logged in" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password: "password",
                                            password_confirmation: "password",
                                            admin: true }}
    assert_not @other_user.reload.admin?                                            
  end
  
  # ログインしていない状態でdestroyアクションを動作させても、ログイン画面へリダイレクト
  test "should redirect destroy when not logged in" do
    #   ユーザー削除を行ってもユーザー数は変わらない
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end
  
  # 管理者権限でないユーザーでは、ユーザー削除できず、ログイン画面へリダイレクト
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    # ユーザー削除を行ってもユーザー数は変わらない
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end
