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
      flash[:success] = "個人情報を編集しました"
      redirect_to mypage_path
    else
      flash[:danger] = '個人情報の編集に失敗しました'
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @end_user = current_end_user
    @end_user.update(is_deleted: false)
    reset_session
    redirect_to root_path
  end

   private

  def end_user_params
    params.require(:end_user).permit(:last_name, :first_name, :kana_first_name, :kana_last_name, :email, :postal_code, :address, :telephone_number)
  end

end
