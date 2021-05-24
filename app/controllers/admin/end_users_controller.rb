class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!


  def index
    @end_users = EndUser.page(params[:page]).per(10)
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update

  end


  private

  def end_user_params
  	params.require(:end_user).permit(:email, :last_name, :first_name, :kana_last_name, :postal_code,:address, :telephone_number, :is_deleted)
  end

end