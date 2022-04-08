class UsersController < ApplicationController
  def index
    @page = params[:page] || 1
    @per_page = params[:per_page] || 10

    @users = User.page(@page).per(@per_page)
    @users = @users.where(query_params) if query_params.present?

    @total_pages = @users.total_pages
    @total_count = @users.total_count
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def query_params
    params.permit(:status)
  end
end
