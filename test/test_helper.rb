# Test helper
# Author: Meagan Moore & Steven Royster

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

#Commented out by KM: Made testing impossible.
  #`require': cannot load such file -- minitest/reporters (LoadError)
#require "minitest/reporters"
#Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if a test user is logged in.
  def is_logged_in?
    !login_session[:teacher_id].nil?
  end

  # Log in as a particular user.
  def log_in_as(teacher)
    login_session[:teacher_id] = teacher.id
  end
end

class ActionDispatch::IntegrationTest

  # Log in as a particular user.
  def log_in_as(teacher, password: 'password')
    post login_path, params: {login_session: {user_name: teacher.user_name,
                                                password: password} }
  end
end
