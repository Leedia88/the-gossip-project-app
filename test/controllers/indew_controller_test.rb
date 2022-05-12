require 'test_helper'

class IndewControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get indew_new_url
    assert_response :success
  end

  test "should get create" do
    get indew_create_url
    assert_response :success
  end

  test "should get show" do
    get indew_show_url
    assert_response :success
  end

  test "should get destroy" do
    get indew_destroy_url
    assert_response :success
  end

end
