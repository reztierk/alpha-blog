require 'test_helper'

class ArticleCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "John", email: "john@example.com", password: "password", admin: true)
  end

  test "create new article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: "Test Article", description: "test article description"}
    end
    assert_template 'articles/show'
    assert_match "Test Article", response.body
  end
end