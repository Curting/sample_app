require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password:              'foo',
                                         password_confirmation: 'bar' }}
    end
    assert_template 'users/new'
    # Check if the error msg appears
    assert_select "div.alert"
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User",
                                         email: "user@example.com",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    # Check if the flash is not empty
    assert_not flash.empty?
  end
end
