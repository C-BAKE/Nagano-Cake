class Admin::OrderDetailsController < ApplicationController
    before_action :authenticate_admin!

	def update
		@ordered_item = OrderedItem.find(params[:id]) #　特定
		@order = @ordered_item.order #注文商品から注文テーブルの呼び出し（何度も呼び出すのは処理が増える為）
		@ordered_item.update(ordered_item_params) #　製作ステータスの更新
		# @order_item = Order.OderItem.find(params[:id])
		# @order_item.update(order_item_params)

		if @ordered_item.production_status == "製作中" #製作ステータスが「製作作中」なら入る
			@order.update(order_status: 2) #注文ステータスを「製作中」　に更新

	#上記の条件に当てはまらなければ、商品の個数の特定　　　　製作ステータスが「製作l完了」の商品をカウント
	#数が一致すれば、全ての商品の製作ステータスが「製作完了」だとわかる
		elsif @order.ordered_items.count ==  @order.ordered_items.where(production_status: "製作完了").count
			@order.update(order_status: 3) #注文ステータスを「発送準備中]に更新
		end
		redirect_to admin_order_path(@ordered_item.order_id) #注文詳細に遷移
	end


	private

	  def ordered_item_params
      params.require(:ordered_item).permit(:production_status)
    end
end

