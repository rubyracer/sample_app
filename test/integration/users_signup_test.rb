require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    user_params = { name: "",
                    email: "user@invalid",
                    password:              "foo",
                    password_confirmation: "bar" }
    assert_no_difference 'User.count' do
      post users_path, params: { user: user_params }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

  test "valid signup information" do
    get signup_path
    user_params = { name: "Example User",
                    email: "user@example.com",
                    password:              "password",
                    password_confirmation: "password" }
    assert_difference 'User.count', 1 do
      post users_path, params: { user: user_params }
      follow_redirect!
    end
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
