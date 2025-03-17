
class PasswordValidator < ActiveModel::EachValidator
  MIN_LENGTH         = 8
  SPECIAL_CHAR_REGEX = /[!@#$%^&*(),.?":{}|<>]/
  DIGIT_REGEX        = /\d/
  UPPERCASE_REGEX    = /[A-Z]/
  LOWERCASE_REGEX    = /[a-z]/

  def validate_each(record, attribute, value)
    return record.errors.add(attribute, :blank) if value.blank?

    unless value.match?(SPECIAL_CHAR_REGEX)
      record.errors.add attribute, :no_special_char
    end

    unless value.match?(DIGIT_REGEX)
      record.errors.add attribute, :no_digit
    end

    unless value.match?(UPPERCASE_REGEX)
      record.errors.add attribute, :no_uppercase
    end

    unless value.match?(LOWERCASE_REGEX)
      record.errors.add attribute, :no_lowercase
    end

    if value.length < MIN_LENGTH
      record.errors.add attribute, :too_short, count: MIN_LENGTH
    end
  end
end
