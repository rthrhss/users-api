# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpsertUser do
  describe '.call' do
    context 'with an existing id' do
      it 'updates the existing user' do
        user = create(:user, first_name: 'John', last_name: 'Doe')
        params = {
          id: user.id,
          first_name: 'Jane',
          last_name: 'Doette',
          email: 'jdoette@email.com',
          status: 'Active',
          created_at: Date.parse('2020-01-01T00:00:00.000Z')
        }

        described_class.call(params)

        expect(user.reload).to have_attributes(params)
      end
    end

    context 'with a new id' do
      it 'creates a new user' do
        params = {
          id: 1,
          first_name: 'Jane',
          last_name: 'Doette',
          email: 'jdoette@email.com',
          status: 'Active',
          created_at: Date.parse('2020-01-01T00:00:00.000Z')
        }

        expect { described_class.call(params) }.to change(User, :count).by(1)
      end

      it 'creates a new user with the right attributes' do
        params = {
          id: 1,
          first_name: 'Jane',
          last_name: 'Doette',
          email: 'jdoette@email.com',
          status: 'Active',
          created_at: Date.parse('2020-01-01T00:00:00.000Z')
        }

        response = described_class.call(params)

        expect(response.user).to have_attributes(params)
      end
    end
  end
end
