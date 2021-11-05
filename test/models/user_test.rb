require 'test_helper'

class UserTest < ActiveSupport::TestCase

    def setup
        @user = User.new(username: "John", email: "john@yahoo.com", password:"password")
    end
    
    test "user should be valid" do
        assert @user.valid?
    end

    test "username should be present" do
        @user.username = " "
        assert_not @user.valid?
    end

    test "username should be unique" do
        @user.save
        @user2 = User.new(username: "John", email: "john@yahoo.com", password:"password")
        assert_not @user2.valid?
    end

    test "username should not be too long" do
        @user.username = "a" * 26
        assert_not @user.valid?
    end

    test "username should not be too short" do 
        @user.username = "aa"
        assert_not @user.valid?
    end

    test "email should be present" do
        @user.email = " "
        assert_not @user.valid?
    end

    test "email should be unique" do
        @user.save
        @user2 = User.new(username: "John", email: "john@yahoo.com", password:"password")
        assert_not @user2.valid?
    end

    test "email should not be too long" do
        @user.email = "a" * 26
        assert_not @user.valid?
    end

    test "email should not be too short" do 
        @user.email = "aa"
        assert_not @user.valid?
    end

    test "email should have the correct format" do 
        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        assert_match(VALID_EMAIL_REGEX, @user.email)
    end


end