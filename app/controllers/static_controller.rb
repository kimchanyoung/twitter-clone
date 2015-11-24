class StaticController < ApplicationController

  def index
    @tweet = Tweet.new
    if logged_in?
      @tweets = current_user.relevant_tweets
    else
      @tweets = Tweet.all
    end
  end

end