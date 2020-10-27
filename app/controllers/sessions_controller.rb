class SessionsController < ApplicationController
  before_action :require_logged_out, except: :destroy
  before_action :require_logged_in, only: :destroy

  def new
    @session = User.new
  end

  def create
    @session = User.new(session_params)
    user = User.find_by(email: @session.email)
    if user&.authenticate(@session.password)
      cookies.signed[:user_id] = user.id
      redirect_to root_path, notice: "Login successful"
    else
      render :new, alert: "Invalid Username and/or Password"
    end
  end

  def destroy
    cookies.delete :user_id
  end

private
  def session_params
    params.require(:user).permit(:email, :password)
  end

end
