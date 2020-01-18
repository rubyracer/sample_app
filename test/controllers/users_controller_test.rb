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

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    user_params_variant = { password: "new_password",
                            password_confirmation: "new_password",
                            admin: 1 }
    # patch :update, id: @other_user, user: { password: FILL_IN, password_confirmation: FILL_IN, admin: FILL_IN }
    patch user_path(@other_user), params: {user: user_params_variant}

    @other_user.reload
    assert_not @other_user.admin?

    @other_user.toggle!(:admin)
    assert @other_user.admin?
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    user_params_variant = { name: @user.name, email: @user.email }
    # patch :update, id: @user, user: { name: @user.name, email: @user.email }
    patch user_path(@user), params: { user: user_params_variant }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      # delete :destroy, id: @user
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      # delete :destroy, id: @user
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

end
