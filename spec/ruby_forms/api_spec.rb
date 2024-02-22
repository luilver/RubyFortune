# frozen_string_literal: true

describe RubyForms::API do
  include Rack::Test::Methods

  def app
    RubyForms::API
  end

  describe 'Swagger documentation' do
    context 'when requesting root documentation path' do
      let(:json) { JSON.parse(last_response.body, symbolize_names: true) }

      before { get '/api/swagger_doc' }

      it { expect(last_response.status).to eq(200) }

      it 'exposes api version' do
        expect(json[:info][:version]).to eq('0.0.3')
      end

      it 'exposes polls api path' do
        expect(json[:paths].size).to eq 1
      end
    end

    context 'when requesting api endpoints' do
      before { get '/api/swagger_doc' }

      it { expect(last_response.status).to eq(200) }
    end

    context 'when requesting poll endpoints' do
      let(:apis) { JSON.parse(last_response.body, symbolize_names: true) }

      let(:poll_docs) { apis[:paths][:'/api/polls'] }

      let(:poll_params) do
        {
          'title' => 'title of the poll',
          'options' => 'options for the poll'
        }
      end

      before { get '/api/swagger_doc/polls' }

      it { expect(last_response.status).to eq(200) }

      it 'exposes poll documentation' do
        expect(poll_docs.keys.length).to be 2
      end

      it 'exposes poll\'s GET' do
        expect(poll_docs).to include :get
      end

      it 'exposes poll\'s POST' do
        expect(poll_docs).to include :post
      end

      it 'exposes poll\'s parameters' do
        parameters = poll_docs[:post][:parameters].to_h do |parameter|
          [parameter[:name], parameter[:description]]
        end

        expect(parameters).to eq(poll_params)
      end
    end
  end
end
