module AssertionsHelper
    def assert_error_on(record, attribute, error_type)
      assert_not record.valid?
      assert_not_empty record.errors.where(attribute, error_type)
    end
end
