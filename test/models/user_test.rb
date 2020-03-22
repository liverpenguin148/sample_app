require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  #テスト用ユーザーの作成
  def setup
    @user = User.new(name: "Test User", email: "test@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  
  #テスト用ユーザーがバリデーションエラーかどうかテスト(valid?メソッド trueが返ればOK)
  test "should be valid" do
    assert @user.valid?
  end
  
  #テスト用ユーザーを空文字にしてテスト(valid?メソッド falseであればOK)
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  
  #テスト用メールアドレスを空文字にしてテスト(valid?メソッド falseであればOK)
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  
  #テスト用ユーザー51文字にしてテスト
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  #テスト用ユーザーメールアドレスを256文字にしてテスト(結果 = false)
  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end
  
  #メールフォーマットのテスト(有効なメールアドレス)
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US_ER@foo.bar.org 
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  #メールフォーマット（無効なメールアドレス）
  test "email validation should accept invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                         foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  #登録するメールアドレスが小文字になっているか
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMpLe.Com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  #メールアドレスの一意性
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  #パスワードの最小文字数
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = "" * 6
    assert_not @user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
end
