class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!

  def show
    @end_user = current_end_user
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

end
