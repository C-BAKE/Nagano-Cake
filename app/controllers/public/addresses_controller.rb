class Public::AddressesController < ApplicationController
  before_action :authenticate_end_user!

  def index
  @addresses = current_end_user.addresses.page(params[:page]).per(3) # ページネーションの追加/3件ごとにページ作成
  @address = Address.new
  end

  def create
  	@address = Address.new(address_params)
  	@address.end_user_id = current_end_user.id
  	@address.save
  	redirect_to addresses_path
  end

  def edit
  	@address = Address.find(params[:id])
  end

  def update
  	@address = Address.find(params[:id])
  	@address.update(address_params)
  	redirect_to addresses_path
  end

  def destroy
  	@address = Address.find(params[:id])
  	@address.destroy
  	redirect_to addresses_path
  end

  private
  def address_params
  	params.require(:address).permit(:name, :end_user_id, :address, :postal_code)
  end

end

