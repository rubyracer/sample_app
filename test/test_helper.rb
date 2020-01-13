ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# 3.7.1 minitest reporters
# https://www.softcover.io/read/db8803f7/ruby_on_rails_tutorial_3rd_edition_russian/static_pages#sec-minitest_reporters
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  include ApplicationHelper
  # Add more helper methods to be used by all tests here...

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Возвращает true, если тестовый пользователь осуществил вход.
  def is_logged_in?
    !session[:user_id].nil?
  end

=begin
# Осуществляет вход тестового пользователя
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end

  private

    # Возвращает true внутри интеграционных тестов
    def integration_test?
      defined?(post_via_redirect)
    end

=end


  # Осуществляет вход тестового пользователя
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      session_params = {
        email: user.email,
        password: password,
        remember_me: remember_me
      }
      post login_path, params: { session: session_params }
    else
      session[:user_id] = user.id
    end
  end

  private

    # Возвращает true внутри интеграционных тестов
    def integration_test?
      defined?(post_via_redirect)
    end
end
