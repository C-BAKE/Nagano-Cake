class Public::HomesController < ApplicationController
  def top
    @items = Item.limit(4)# 先頭から4つのレコードを取得
  end
  
  def about
  end

end
