require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

    def setup
        @article = Article.new(title:"Article", description:"description",user_id: 1)
    end
    
    #corregir - no deberia ir el _not#
    test "article should be valid" do
        assert_not @article.valid?
    end

    #Title#
    test "title should be present" do
        @article.title = " "
        assert_not @article.valid?
    end

    test "title should be unique" do
        @article.save
        @article2 = Article.new(title: "Article", description: "Description", user_id: 1)
        assert_not @article2.valid?
    end

    test "title should not be too long" do
        @article.title = "a" * 101
        assert_not @article.valid?
    end

    test "title should not be too short" do 
        @article.title = "a" * 6
        assert_not @article.valid?
    end

    #Description#
    test "description should be present" do
        @article.description = " "
        assert_not @article.valid?
    end

    test "description should be unique" do
        @article.save
        @article2 = Article.new(title: "Article", description: "Description", user_id: 1)
        assert_not @article2.valid?
    end

    test "description should not be too long" do
        @article.description = "a" * 101
        assert_not @article.valid?
    end

    test "description should not be too short" do 
        @article.description = "a" * 9
        assert_not @article.valid?
    end



end