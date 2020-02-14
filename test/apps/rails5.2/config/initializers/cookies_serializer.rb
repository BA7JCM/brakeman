# Be sure to restart your server when you modify this file.

# Specify a serializer for the signed and encrypted cookie jars.
# Valid options are :json, :marshal, and :hybrid.
Rails.application.config.action_dispatch.cookies_serializer = :hybrid

module Custom
  module Serializer
  end
end

Rails.application.config.action_dispatch.cookies_serializer = Custom::Serializer