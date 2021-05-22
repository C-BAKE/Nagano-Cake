class Public::OrdersController < ApplicationController


  def index
  end

  def show
  end

  def new
    @order = Order.new
    @address = Address.new
  end

  def create
  end

  def confirm
  end

  def complete
  end

end
