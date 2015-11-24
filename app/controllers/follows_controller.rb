class FollowsController < ApplicationController

  def new
    @follow = Follow.new
  end

  def create
    @follow = Follow.new(follow_params)
    @follow.follower = current_user
    respond_to do |format|
      if @follow.save
        format.html { redirect_to @follow.followee, notice: 'Following!' }
      else
        format.html { render :new }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @follow = Follow.find_by(id: params[:id])
    @follow.destroy
    redirect_to root_path
  end

  private

  def follow_params
    params.require(:follow).permit(:followee_id)
  end
end
