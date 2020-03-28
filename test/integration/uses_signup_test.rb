require 'test_helper'

class UsesSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    #getメソッドでユーザー登録ページにアクセス
    get signup_path
    
    # postメソッドを使用した（フォーム送信テスト）
    # assert_no_difference 'User.count' User.countの値がブロック実行前後で変わらないことテスト
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" }}
    end
    # 指定されたテンプレートが選択されたか
    assert_template 'users/new'
    
    # formタグ内に/signupがあれば、成功
    assert_select 'form[action="/signup"]'
    
    # id = error_explanationが描画されているかテスト
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "valid signup information" do
    get signup_path
    # post送信後、1ユーザーが増えたかどうかテスト
    assert_difference "User.count", 1 do
      post users_path, params: { user: {name: "Example User",
                                        email: "user@example.com",
                                        password:              "password",
                                        password_confirmation: "password"}}
    follow_redirect!                                        
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
    end
  end
end
