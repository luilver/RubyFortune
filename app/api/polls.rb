# frozen_string_literal: true

module RubyForms
  # Base Resource
  class Polls < Grape::API
    resource :polls do
      desc 'returns polls details'
      get do
        polls = ::Poll.all
        present polls, with: RubyForms::Entities::Poll, with_options: true
      end

      desc 'create a poll'
      params do
        requires :title, type: String, desc: 'title of the poll'
        optional :options, type: [String], desc: 'options for the poll'
      end
      post do
        poll = ::Poll.create(title: params[:title])
        present poll, with: RubyForms::Entities::Poll
      end
    end
  end
end
