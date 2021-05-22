class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!

  def show
    @end_user = current_end_user
  end

  def edit
    @end_user = current_end_user
  end

  def update
    @end_user = current_end_user
    if @end_user.update(end_user_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
  end

   private

  def set_current_end_user
    @customer = current_end_user
  end

  def end_user_params
    params.require(end_user).permit(:last_name, :first_name, :kana_first_name, :kana_last_name, :email, :postal_code, :address, :telephone_number)
  end

end
