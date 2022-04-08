# frozen_string_literal: true

namespace :users do
  desc 'Updates the users table with the latest data from the API'
  task update: :environment do
    UpdateUsersWorker.perform_async
  end
end
