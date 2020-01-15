require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get "/signup"
    assert_response :success
  end

  test "should redirect index when not logged in" do
    # get :index
    get "/users"
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    # get :edit, id: @user
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    user_params_variant = { name: @user.name, email: @user.email }
    # patch :update, id: @user, user: { name: @user.name, email: @user.email }
    patch user_path(@user), params: { user: user_params_variant }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    # get :edit, id: @user
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    user_params_variant = { name: @user.name, email: @user.email }
    # patch :update, id: @user, user: { name: @user.name, email: @user.email }
    patch user_path(@user), params: { user: user_params_variant }
    assert flash.empty?
    assert_redirected_to root_url
  end

end
