class Public::OrdersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_cart_items, only: [:new, :confirm, :create, :error]

  def index
    @orders = current_end_user.orders
  end

  def show
    @order = Order.find(params[:id]) #order特定
    @ordered_item = @order.ordered_items #特定したorserからorder_items全部取得
    @total = 0 #変数提議　合計を計算する変数
  end

  def new
    @order = Order.new
    @address = Address.new
  end


  def confirm
    @end_user = current_end_user
    @cart_items = CartItem.where(end_user_id: current_end_user.id) #自身のカートから買った商品情報を取得代入
    @total = 0 ##変数提議　合計を計算する変数
    params[:order][:payment_method] = params[:order][:payment_method].to_i #payment_methodの数値に変換
    @order = Order.new(order_params) #情報を渡している
  #分岐
    if params[:order][:address_number] == "1" #address_numberが　”1”　なら下記　ご自身の住所が選ばれたら
      @order.postal_code = current_end_user.postal_code #自身の郵便番号をorderの郵便番号に入れる
      @order.address = current_end_user.address #自身の住所をorderの住所に入れる
      @order.name = current_end_user.last_name+current_end_user.first_name #自身の宛名をorderの宛名に入れる

    elsif  params[:order][:address_number] ==  "2" #address_numberが　”2”　なら下記　登録済からの選択が選ばれたら
      @order.postal_code = Address.find(params[:order][:id]).postal_code #newページで選ばれた配送先住所idから特定して郵便番号の取得代入
      @order.address = Address.find(params[:order][:id]).address #newページで選ばれた配送先住所idから特定して住所の取得代入
      @order.name = Address.find(params[:order][:id]).name #newページで選ばれた配送先住所idから特定して宛名の取得代入

    elsif params[:order][:address_number] ==  "3" #address_numberが　”3”　なら下記　新しいお届け先が選ばれたら
      @address = Address.new() #変数の初期化
      @address.address = params[:order][:address] #newページで新しいお届け先に入力した住所を取得代入
      @address.name = params[:order][:name] #newページで新しいお届け先に入力した宛名を取得代入
      @address.postal_code = params[:order][:postal_code] #newページで新しいお届け先に入力した郵便番号を取得代入
      @address.end_user_id = current_end_user.id #newページで新しいお届け先に入力したmember_idを取得代入
      if @address.save #保存
      @order.postal_code = @address.postal_code #上記で代入された郵便番号をorderに代入
      @order.name = @address.name #上記で代入された宛名をorderに代入
      @order.address = @address.address #上記で代入された住所をorderに代入
      else
       render 'new'
      end
    end
  end

  def complete
  end

  def create
    @order = Order.new(order_params) #初期化代入
    @order.end_user_id = current_end_user.id #自身のidを代入
    @order.save #orderに保存
#order_itmemの保存
  current_end_user.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
    @ordered_item = OrderedItem.new #初期化宣言
    @ordered_item.item_id = cart_item.item_id #商品idを注文商品idに代入
    @ordered_item.quantity = cart_item.quantity #商品の個数を注文商品の個数に代入
    @ordered_item.price = (cart_item.item.non_taxed_price*1.1).floor #消費税込みに計算して代入
    @ordered_item.order_id =  @order.id #注文商品に注文idを紐付け
    @ordered_item.save #注文商品を保存
  end #ループ終わり

    current_end_user.cart_items.destroy_all #カートの中身を削除
    redirect_to complete_path #completeに遷移

  end



  private

  def order_params
    params.require(:order).permit(:payment_method, :address, :postage, :postal_code, :name, :payment)
  end

  def ensure_cart_items
    @cart_items = current_end_user.cart_items.includes(:item)
    redirect_to items_path unless @cart_items.first
  end

end
