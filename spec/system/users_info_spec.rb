# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users info', type: :system do
  let(:user) { create(:user) }

  it 'shows info about the user' do
    visit user_path(user)

    assert_text user.id
    assert_text user.first_name
    assert_text user.last_name
    assert_text user.email
    assert_text user.status
    assert_text user.created_at
  end

  it 'redirects to users list if link is clicked' do
    visit user_path(user)

    click_link 'Back to list'

    expect(page).to have_current_path(users_path)
  end
end

