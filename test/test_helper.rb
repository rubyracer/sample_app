ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# 3.7.1 minitest reporters
# https://www.softcover.io/read/db8803f7/ruby_on_rails_tutorial_3rd_edition_russian/static_pages#sec-minitest_reporters
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include ApplicationHelper
  # Add more helper methods to be used by all tests here...
end
