ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require_relative "helpers/assertions_helper"

class ActiveSupport::TestCase
  include AssertionsHelper
  
  parallelize(workers: :number_of_processors)


  fixtures :all
  
end
