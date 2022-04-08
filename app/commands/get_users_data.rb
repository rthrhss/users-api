# frozen_string_literal: true

class GetUsersData
  include Interactor

  BASE_URL = 'https://microverse-api-app.herokuapp.com/users'
  DEFAULT_LIMIT = 100

  def call
    results = []
    offset = 0

    loop do
      response = fetch(offset)
      break if response.size < limit

      results += response
      offset += limit
    end

    context.users_data = results
  end

  private

  def limit
    context.limit || DEFAULT_LIMIT
  end

  def fetch(offset)
    response = request_for(offset).run

    unless response.code == 200
      context.fail!(
        code: response.code,
        message: response.status_message
      )
    end

    JSON.parse(response.body)
  end

  def request_for(offset)
    Typhoeus::Request.new(
      "#{BASE_URL}?offset=#{offset}&limit=#{limit}",
      headers: { 'Authorization' => context.api_key }
    )
  end
end
