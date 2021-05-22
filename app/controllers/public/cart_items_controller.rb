class Public::CartItemsController < ApplicationController
 before_action :authenticate_end_user!
 before_action :set_cart_item, only: [:create, :update, :destroy]


  def index
    @cart_items = current_end_user.cart_items.includes(:item)
  end

  def create
    # if @cart_item
    #   new_quantity = @cart_item.quantity + cart_item_params[:quantity]
    #   @cart_item.update(quantity: new_quantity)
    #   redirect_to cart_items_path
    # else
      @cart_item = current_end_user.cart_items.new(cart_item_params)
      @cart_item.item_id = @item.id
     # binding.pry
      if @cart_item.save
        redirect_to cart_items_path
      else
        render 'public/items/show'
      end
    #end
  end

  def update
    @cart_item.update(cart_item_params) if @cart_item
    redirect_to cart_items_path
  end

  def destroy
    @cart_item.destroy if @cart_item
    redirect_to cart_items_path
  end

  def destroy_all
    current_end_user.cart_items.destroy_all
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

  def set_cart_item
    @item = Item.find(params[:cart_item][:item_id])
    #@cart_item = current_end_user.has_in_cart(@item)
  end
end