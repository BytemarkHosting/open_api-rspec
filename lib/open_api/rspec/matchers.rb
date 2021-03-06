# frozen_string_literal: true

module OpenApi
  module RSpec
    module Matchers
      ::RSpec::Matchers.define :match_openapi_response_schema do |schema|
        match do |response|
          ::OpenApi::SchemaValidator.validate_schema!(
            open_api_json,
            response.is_a?(Hash) ? response : ::JSON.parse(response.body),
            fragment: "#/definitions/#{schema}"
          )
        end
      end

      ::RSpec::Matchers.define :be_valid_openapi_schema do
        match do |string|
          json = ::JSON.parse(string)
          ::OpenApi::SchemaValidator.validate!(json)
        end
      end
    end
  end
end
