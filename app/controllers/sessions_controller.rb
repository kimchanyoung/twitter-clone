class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: user_params[:username])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_session_path(@user)
    end
  end

  def delete
    session[:user_id] = nil
    flash[:message] = "Successful logout. See you next time!"
    redirect_to root_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.permit(:username, :password)
  end
end
