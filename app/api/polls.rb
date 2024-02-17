# frozen_string_literal: true

module RubyForms
  # Base Resource
  class Polls < Grape::API
    resource :forms do
      desc 'Returns basic form details'
      get '/polls' do
        polls = ::Poll.all
        present polls, with: RubyForms::Entities::Poll, with_options: true
      end

      desc 'Create a basic poll'
      params do
        requires :title, type: String, desc: 'Title of the poll'
        requires :options, type: Array[String], desc: 'Options for the poll'
      end
      post '/poll' do
        poll = ::Poll.new({ title: params[:title], options: params[:options] })
        present poll, with: Entities::PollEntity
      end
    end
  end
end
