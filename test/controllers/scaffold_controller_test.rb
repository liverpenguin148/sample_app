require 'test_helper'

class ScaffoldControllerTest < ActionDispatch::IntegrationTest
  test "should get StaticPages" do
    get scaffold_StaticPages_url
    assert_response :success
  end

  test "should get home" do
    get scaffold_home_url
    assert_response :success
  end

  test "should get help" do
    get scaffold_help_url
    assert_response :success
  end

end
