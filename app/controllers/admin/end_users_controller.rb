class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @end_users = EndUser.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
  end
end
