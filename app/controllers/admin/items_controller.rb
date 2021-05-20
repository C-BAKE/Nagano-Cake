class Admin::ItemsController < ApplicationController

  def index
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
  end

  private

  def item_params
    params.permit(:name, :description, :non_taxed_price, :is_active)
  end


end
