ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

Dir[Rails.root.join("test/helpers/**/*.rb")].sort.each { |file| require file }

class ActiveSupport::TestCase
  include AssertionsHelper

  parallelize(workers: :number_of_processors)

 fixtures :all
end
