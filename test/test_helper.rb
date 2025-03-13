ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

 
  def assert_error_on(record, attribute, error_type)
    assert_not record.valid?
    assert_not_empty record.errors.where(attribute, error_type)
  end

  
end
