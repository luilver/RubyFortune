# frozen_string_literal: true

module RubyForms
  # API class
  class API < Grape::API
    prefix 'api'
    format :json

    mount ::RubyForms::Polls

    add_swagger_documentation api_version: 'v1'
  end
end
