class OneTimePassword
  # ActiveModel::Model introduced in Rails 4
  include ActiveModel::Model

  attr_accessor :value

  validates :value, format: /[0-9]/
end
