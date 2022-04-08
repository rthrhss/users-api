# frozen_string_literal: true

class UpsertUser
  include Interactor

  def call
    context.user = User.where(id: context.id).first_or_initialize.tap do |user|
      user.assign_attributes(user_attributes)
      user.save
    end
  end

  private

  def user_attributes
    {
      id: context.id,
      first_name: context.first_name,
      last_name: context.last_name,
      email: context.email,
      status: context.status,
      created_at: context.created_at
    }
  end
end
