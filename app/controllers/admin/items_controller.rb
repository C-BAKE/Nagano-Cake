class Admin::ItemsController < ApplicationController

  def index
    @items  = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
  	if @item.save
  	   redirect_to admin_item_path(@item)
  	else
  	   render "new"
  	end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
  	if @item.update(item_params)
  	  redirect_to admin_item_path(@item.id)
  	else
  		render "edit"
  	end

  end


  private

    def item_params
      params.permit(:name, :description, :non_taxed_price, :is_active, :image_id)
    end

end

