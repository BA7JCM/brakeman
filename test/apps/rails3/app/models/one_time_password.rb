class OneTimePassword
  # ActiveModel::Validations introduced in Rails 3
  include ActiveModel::Validations

  attr_accessor :value

  validates_format_of :value, with: /[0-9]/
end
