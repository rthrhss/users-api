# frozen_string_literal: true

class UpdateUsersWorker
  include Sidekiq::Worker

  def perform
    response = GetUsersData.call(api_key: api_key)

    raise StandardError, response.message if response.failure?

    response.users_data.each do |user_attributes|
      UpsertUser.call(user_attributes)
    end
  end

  private

  def api_key
    ENV['USERS_API_KEY']
  end
end
