class StaticController < ApplicationController

  def index
    @tweet = Tweet.new
  end

end