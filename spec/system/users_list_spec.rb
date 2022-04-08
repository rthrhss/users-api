# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users list', type: :system do
  before do
    create_list(:user, 15)
  end

  it 'lists 10 users on the first page' do
    visit users_path

    assert_selector '[data-test="user"]', count: 10
  end

  it 'lists 5 users on the second page' do
    visit users_path

    click_on 'Next'
    assert_selector '[data-test="user"]', count: 5
  end

  it 'opens the user page when clicking on the user id' do
    visit users_path

    first('[data-test="user"]').click_link

    expect(page).to have_current_path(user_path(User.first))
  end
end
