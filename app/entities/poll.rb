# frozen_string_literal: true

module RubyForms
  module Entities
    # Poll Entity
    class Poll < Grape::Entity
      expose :id
      expose :title

      with_options if: :with_options do
        expose :options, with: Entities::Option
      end
    end
  end
end
