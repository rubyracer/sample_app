require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    user_params_variant = { name:  "",
                    email: "foo@invalid",
                    password:              "foo",
                    password_confirmation: "bar"
                  }
    patch user_path(@user), params: { user: user_params_variant }
    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)

    # homework example 1
    assert_nil session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to @user

    name  = "Foo Bar"
    email = "foo@bar.com"
    user_params_variant = { name:  name,
                    email: email,
                    password:              "",
                    password_confirmation: ""
                  }
    patch user_path(@user), params: { user: user_params_variant }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
