require 'test_helper'

class AuthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auth = auths(:one)
  end

  test "should get index" do
    get auths_url
    assert_response :success
  end

  test "should get new" do
    get new_auth_url
    assert_response :success
  end

  test "should create auth" do
    assert_difference('Auth.count') do
      post auths_url, params: { auth: {  } }
    end

    assert_redirected_to auth_url(Auth.last)
  end

  test "should show auth" do
    get auth_url(@auth)
    assert_response :success
  end

  test "should get edit" do
    get edit_auth_url(@auth)
    assert_response :success
  end

  test "should update auth" do
    patch auth_url(@auth), params: { auth: {  } }
    assert_redirected_to auth_url(@auth)
  end

  test "should destroy auth" do
    assert_difference('Auth.count', -1) do
      delete auth_url(@auth)
    end

    assert_redirected_to auths_url
  end
end
