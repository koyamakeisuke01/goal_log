class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order("updated_at DESC")
  end

  def edit
    user_check
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:avatar, :name, :email, :introduction)
  end

  def user_check
    user = User.find(params[:id])
    if user_signed_in? && current_user.id != user.id
      redirect_to root_path
    end
  end
end