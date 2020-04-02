require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:taka)
    @non_admin = users(:archer)
  end
  
  test "index as admin including pagination and delete links" do
    # ログインする(管理者)
    log_in_as(@admin)
    # indexアクションページへ
    get users_path
    # 一覧（index）ページの表示
    assert_template 'users/index'
    # ページネーションタグが存在するか
    assert_select 'div.pagination'
    # ユーザーページの1ページ目を選択
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      # 各々のユーザーページへのリンクがあるか
      assert_select 'a[href=?]', user_path(user), text: user.name
      # adminユーザーでない場合
      unless user == @admin
        # ユーザー削除するリンクが作成できているか
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    # ユーザー削除した場合、1ユーザー減る
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end
  
  test "index as non-admin" do
    # 管理者権限でないユーザーでログイン
    log_in_as(@non_admin)
    # indexアクション
    get users_path
    # <a>delete</a>の数が0であることを確認
    assert_select 'a', text: 'delete', count:0
  end
end
