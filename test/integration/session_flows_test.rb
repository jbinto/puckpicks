require 'test_helper'

class SessionFlowsTest < ActionDispatch::IntegrationTest

  test "successful authentication" do
    FactoryGirl.create(:user, :username => "jdoe", :password => "abc123")

    perform_login('jdoe', 'abc123')

    assert_equal root_path, current_path
    assert page.has_content? 'Log out (jdoe)'
  end

  test "unsuccessful authentication" do
    perform_login('jdoe', 'abc123')

    assert_equal '/login', current_path
    assert page.has_content? 'password was invalid'
  end
  
  protected
  def perform_login user, password
    visit '/login'
    fill_in 'login[username]', with: user
    fill_in 'login[password]', with: password
    click_button 'Log in'
  end

end
