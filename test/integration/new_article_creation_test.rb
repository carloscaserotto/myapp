require "test_helper"

class NewArticleCreationTest < ActionDispatch::IntegrationTest

    setup do
      @admin_user = User.create(username: "johndoe", email:"johndoe@example.com",
                               password: "password", admin: true)
      sign_in_as(@admin_user)
      #@category = Category.create(name: "Sports")
    end
  
    test "get new article form and create new article" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "Some title", description: "Some description", 
                                              category_ids: [] } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Some title", response.body
   end
   
   test "get new article form and reject invalid create new article submission" do
    get "/articles/new"
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: " ", description: "Some description", 
                                              category_ids: [] } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
