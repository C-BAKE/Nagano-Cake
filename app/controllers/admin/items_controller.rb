class Admin::ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
  end



  def create
    @item = Item.new(item_params)
  	if @item.save
  	   redirect_to admin_item_path(@item)
  	else
  	   render "new"
  	end
  end

  def show
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
  end

  private

  def item_params
  	params.require(:item).permit(:genre_id,:item_name,:unit_price_without_tax,:sale_status,:explanation,:image)
  end


end
