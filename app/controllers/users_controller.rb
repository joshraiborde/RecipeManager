class UsersController < ApplicationController
  before_action :require_logged_in, only: %i[show]
  before_action :require_logged_out, except: %i[show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies.signed[:user_id] = @user.id
      redirect_to user_path, notice: "User saved successfully"
    else
      render :new, alert: "User failed to save"
    end
  end

  def show
    @user = current_user
    @ratings = @user.ratings
  end

private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
