# frozen_string_literal: true

# Class Poll
class Poll < ActiveRecord::Base
  has_many :options

  validates :title, presence: true
end
