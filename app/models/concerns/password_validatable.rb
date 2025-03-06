module PasswordValidatable
  MIN_LENGTH = 8
  SPECIAL_CHAR_REGEX = /[!@#$%^&*(),.?":{}|<>]/
  DIGIT_REGEX = /\d/
  UPPERCASE_REGEX = /[A-Z]/
  LOWERCASE_REGEX = /[a-z]/

  def self.valid?(password)
    return false if password.length < MIN_LENGTH
    return false unless password.match?(SPECIAL_CHAR_REGEX)
    return false unless password.match?(DIGIT_REGEX)
    return false unless password.match?(UPPERCASE_REGEX)
    return false unless password.match?(LOWERCASE_REGEX)

    true
  end
end
