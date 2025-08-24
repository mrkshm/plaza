require "test_helper"

class User::AuthenticationTest < ActiveSupport::TestCase
  test "password must be at least 6 characters long" do
    @user = User.new(valid_user.merge(password: "short"))
    assert_not @user.valid?
  end

  test "password cannot be longer than ActiveRecord Max" do
    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    @user = User.new(valid_user.merge(password: "a" * (max_length + 1)))
    assert_not @user.valid?
  end

  test "can create a session with email and correct password" do
    @app_session = User.create_app_session(
      email: "jerry@example.com",
      password: "password"
    )

    assert_not_nil @app_session
    assert_not_nil @app_session.token
  end

  test "cannot create a session with incorrect password" do
    @app_session = User.create_app_session(
      email: "jerry@example.com",
      password: "incorrect"
    )

    assert_nil @app_session
  end

  test "cannot create a session with incorrect email" do
    @app_session = User.create_app_session(
      email: "dongus@dingus.com",
      password: "password"
    )

    assert_nil @app_session
  end

  test "can authenticate with valid session id and token" do
    @user = users(:jerry)
    @app_session = @user.app_sessions.create

    assert_equal @app_session, @user.authenticate_app_session(@app_session.id, @app_session.token)
  end

  test "trying to authenticate with a token that does not exist returns false" do
    @user = users(:jerry)

    assert_not @user.authenticate_app_session(15, "token")
  end
end