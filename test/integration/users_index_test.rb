require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = @admin = users(:michael)
    @non_admin = users(:archer)
    @first_page_of_five_users = User.paginate(page: 1, per_page: 5)
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    @first_page_of_five_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    @first_page_of_five_users.each do |user|
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'Finish him!'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
