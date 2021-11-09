require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  
  test "get sign up form and create user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "johndoe", email:"johndoe@example.com",
                                  password: "password", admin: true } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "johndoe", response.body
  end

  test "get sign up form and reject create user submission" do
    get "/signup"
    assert_response :success
    assert_no_difference 'Category.count' do
      post users_path, params: { user: { username: " ", email:"johndoe@example.com",
                                    password: "password", admin: true } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
  
end
