require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @baase_title = "Ruby on Rails Tutorial Sample App"
  end
  
  #rootルーティングに対するテスト
  test "should get root" do
    get root_url
    assert_response :success
  end
  
  test "should get home" do
    # Homeページのテスト 
    # GETリクエストをhomeアクションに対して送信
    get static_pages_home_url
    assert_response :success
    #セレクタ "title" の値のテスト
    #assert_select "title", "Home | #{@baase_title}"
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    #セレクタ "title" の値のテスト
    assert_select "title", "Help | #{@baase_title}"
  end
  
  test "should get about" do
    get static_pages_about_url
    assert_response :success
    #セレクタ "title" の値のテスト
    assert_select "title", "About | #{@baase_title}"
  end
  
  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
    #セレクタ "title" の値のテスト
    assert_select "title", "Contact | #{@baase_title}"
  end

end
