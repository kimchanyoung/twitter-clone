class StaticController < ApplicationController

  def index
    @tweet = Tweet.new
    if logged_in?
      @tweets = Tweet.relevant_to(current_user)
    else
      @tweets = Tweet.all
    end
  end

end