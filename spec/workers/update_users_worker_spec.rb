# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateUsersWorker, type: :worker do
  # What am I really testing here?
  # I could test that the worker is enqueueing jobs correctly, but that's
  # probably not the point.
  #
  context 'when request is successful' do
    it 'should create or update users' do
      api_response = [{ id: 1, first_name: 'John', last_name: 'Doe' }]

      allow(GetUsersData)
        .to receive(:call)
        .and_return(double(failure?: false, users_data: api_response))

      expect { described_class.new.perform }.to change { User.count }.by(1)
    end
  end

  context 'when request is not successful' do
    it 'should raise an error' do
      allow(GetUsersData)
        .to receive(:call)
        .and_return(double(failure?: true, message: 'API error'))

      expect { described_class.new.perform }.to raise_error(StandardError, 'API error')
    end
  end
end
