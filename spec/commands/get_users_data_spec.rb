# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetUsersData do
  describe '.call' do
    context 'with a valid api key' do
      it 'returns a successful response', :vcr do
        response = described_class.call(api_key: 'secret')

        expect(response).to be_a_success
      end

      it 'returns hashes with the correct attributes', :vcr do
        response = described_class.call(api_key: 'secret')

        expect(response.users_data).to all(
          match(
            'id' => Integer,
            'first_name' => String,
            'last_name' => String,
            'email' => String,
            'status' => String,
            'created_at' => String
          )
        )
      end

      it 'gets data from all pages', :vcr do
        response = described_class.call(api_key: 'secret', limit: 25)

        expect(response.users_data.size).to eq(100)
      end
    end

    context 'with an invalid api key' do
      it 'returns a failed response', :vcr do
        response = described_class.call(api_key: nil)

        expect(response).to be_a_failure
      end

      it 'returns a message', :vcr do
        response = described_class.call(api_key: nil)

        expect(response.message).to eq 'Forbidden'
      end
    end
  end
end
