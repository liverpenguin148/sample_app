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
  
  test "should get help" do
    get help_url
    assert_response :success
    #セレクタ "title" の値のテスト
    assert_select "title", "Help | #{@baase_title}"
  end
  
  test "should get about" do
    get about_url
    assert_response :success
    #セレクタ "title" の値のテスト
    assert_select "title", "About | #{@baase_title}"
  end
  
  test "should get contact" do
    get contact_url
    assert_response :success
    #セレクタ "title" の値のテスト
    assert_select "title", "Contact | #{@baase_title}"
  end
end
