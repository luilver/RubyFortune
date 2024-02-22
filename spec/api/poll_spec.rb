# frozen_string_literal: true

describe Poll do
  include Rack::Test::Methods

  def app
    RubyForms::API
  end

  describe 'Factories' do
    it 'has a valid factory' do
      expect(build(:poll)).to be_valid
    end
  end

  describe 'Validations' do
    it 'is invalid without a title' do
      expect(build(:poll, title: nil)).not_to be_valid
    end
  end

  describe 'GET api/polls' do
    context 'when there are no polls' do
      before { get 'api/polls' }

      it { expect(last_response.status).to eq(200) }

      it 'returns an empty array' do
        expect(JSON.parse(last_response.body)).to eq([])
      end
    end

    context 'when there are polls' do
      before do
        create_list(:poll, 3, :with_options)
        get 'api/polls'
      end

      it { expect(last_response.status).to eq(200) }

      it 'returns 3 polls' do
        expect(JSON.parse(last_response.body).count).to eq(3)
      end
    end
  end

  describe 'POST api/polls' do
    let(:poll_params) do
      {
        title: Faker::Lorem.question
      }
    end
    let(:option_params) do
      {
        text: Faker::Lorem.sentence
      }
    end

    context 'when a poll is created' do
      before do
        post 'api/polls', poll_params
      end

      it 'returns 201 created' do
        expect(last_response.status).to eq(201)
      end

      it 'increases Poll\'s count in 1' do
        expect(described_class.count).to be(1)
      end
    end
  end
end
