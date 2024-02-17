# frozen_string_literal: true

module RubyForms
  module Entities
    # Option Entity
    class Option < Grape::Entity
      expose :id
      expose :text
      expose :is_correct
    end
  end
end
