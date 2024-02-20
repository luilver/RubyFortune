# frozen_string_literal: true

describe RubyForms::API do
  include Rack::Test::Methods

  def app
    RubyForms::API
  end

  describe 'Swagger documentation' do
    context 'root' do
      before do
        get '/api/swagger_doc'
        @json = JSON.parse(last_response.body, symbolize_names: true)
      end

      it { expect(last_response.status).to eq(200) }

      it 'exposes api version' do
        expect(@json[:info][:version]).to eq('0.0.2')
      end

      it 'exposes polls api path' do
        expect(@json[:paths].size).to eq 1
      end
    end

    context 'api' do
      before { get '/api/swagger_doc' }

      it { expect(last_response.status).to eq(200) }
    end

    context 'polls api' do
      let(:poll_params) do
        {
          'title' => 'title of the poll',
          'options' => 'options for the poll'
        }
      end

      before do
        get '/api/swagger_doc/polls'
        apis = JSON.parse(last_response.body, symbolize_names: true)
        @polls_doc = apis[:paths][:'/api/polls']
      end

      it { expect(last_response.status).to eq(200) }

      it 'exposes poll documentation' do
        expect(@polls_doc.keys.length).to eql 2
      end

      it 'exposes poll\'s GET and POST' do
        expect(@polls_doc).to include :get
        expect(@polls_doc).to include :post
      end

      it 'exposes poll\'s parameters' do
        parameters = @polls_doc[:post][:parameters].map do |parameter|
          [parameter[:name], parameter[:description]]
        end.to_h

        expect(parameters).to eq(poll_params)
      end
    end
  end
end
