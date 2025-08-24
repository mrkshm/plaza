require "test_helper"

def valid_user
  {
    name: "john",
    email: "john@example.com",
    password: "password"
    # password_confirm: "password"
  }
end
class UserTest < ActiveSupport::TestCase
  test "requires a name" do
    @user = User.new(valid_user.merge(name: ""))
    assert_not @user.valid?
  end

  test "requires a valid email" do
    @user = User.new(valid_user)
    assert @user.valid?

    @user.email = ""
    assert_not @user.valid?

    @user.email = "invalid_email"
    assert_not @user.valid?
  end

  test "requires a unique email" do
    @existing_user = User.create(valid_user)
    assert @existing_user.persisted?

    @user = User.new(valid_user)
    assert_not @user.valid?
  end

  test "name and email are stripped of extraneous whitespace" do
    @user = User.new(valid_user.merge(name: "  john  ", email: "  john@example.com  "))
    assert @user.valid?
    assert_equal "john", @user.name
    assert_equal "john@example.com", @user.email
  end

  test "password is required" do
    @user = User.new(valid_user.merge(password: ""))
    assert_not @user.valid?
  end
end
