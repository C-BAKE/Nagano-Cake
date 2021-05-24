class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!


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
  	@ordered_items = @order.ordered_items
  end

  def update
    @order = Order.find(params[:id]) #注文詳細の特定
  	@ordered_items = @order.ordered_items #注文から紐付く商品の取得
  	@order.update(order_params) #注文ステータスの更新

 
 	  if @order.order_status == "入金確認" #注文ステータスが入金確認なら下の事をする
	     @ordered_items.update_all(production_status: 1) #製作ステータスを「製作待ちに」　更新
	  end
  		 redirect_to  admin_order_path(@order) #注文詳細に遷移
  end


  private

  def order_params
  	params.require(:order).permit(:order_status)
  end

end
