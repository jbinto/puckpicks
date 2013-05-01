require 'test_helper'

class SessionFlowsTest < ActionDispatch::IntegrationTest

  test "successful authentication" do
    FactoryGirl.create(:user, :username => "jdoe", :password => "abc123")

    perform_login('jdoe', 'abc123')

    assert_was_logged_in
  end

  test "unsuccessful authentication" do
    perform_login('jdoe', 'abc123')

    assert_was_not_logged_in
  end

  test "username is case insensitive when authenticating" do
    FactoryGirl.create(:user, :username => "JDoe", :password => "abc123")
    perform_login('jdoe', 'abc123')

    assert_was_logged_in
  end

  protected
  def perform_login user, password
    visit '/login'
    fill_in 'login[username]', with: user
    fill_in 'login[password]', with: password
    click_button 'Log in'
  end

  def assert_was_logged_in
    assert_equal root_path, current_path
    assert page.has_content? 'Log out'
  end

  def assert_was_not_logged_in
    assert_equal '/login', current_path
    assert page.has_content? 'password was invalid'
  end

end
