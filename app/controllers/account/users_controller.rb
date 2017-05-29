class Account::UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user

  end

  def update
    @user = current_user
    @user.update(user_params)
    if @user.save
      flash[:notice] = "收货信息已更新"
      redirect_to edit_account_user_path(current_user)
    else
      render :edit

    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :address)

  end
end
