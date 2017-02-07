require 'test_helper'

class SignUpUsersTest < ActionDispatch::IntegrationTest

  test "get new user form and sign_up" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: "John", email: "john@example.com", password: "password", admin: false}
    end
    assert_template 'users/show'
    assert_match "John", response.body
  end
end