# frozen_string_literal: true

module RubyForms
  # API class
  class API < Grape::API
    prefix 'api'
    format :json

    mount ::RubyForms::Poll

    add_swagger_documentation api_version: 'v1',
                              doc_version: '0.0.3',
                              info: { title: 'RubyForms API V1' }
  end
end
