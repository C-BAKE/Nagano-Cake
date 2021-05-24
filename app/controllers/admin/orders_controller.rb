class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!
    before_action :ensure_order, only: [:show, :update]

  def index
    @order = Order.all
    if params[:end_user_id]
      @end_user = EndUser.find(params[:end_user_id])
      @orders = @end_user.orders.page(params[:page]).reverse_order
    elsif params[:created_at] == "today"
      @orders = Order.ordered_today.includes(:end_user).page(params[:page]).reverse_order
    else
      @orders = Order.includes(:end_user).page(params[:page]).reverse_order
    end
  end

  def show
      	# 注文内容の情報を取得しています！
  	@order = Order.find(params[:id])
    # 注文内容の商品を取得しています！
  	@order_items = @order.order_items
  end

  def update
  end


  private

  def order_params
  	params.require(:order).permit(:order_status)
  end

end
